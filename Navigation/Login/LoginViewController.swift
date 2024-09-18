//
//  LoginViewController.swift
//  Navigation
//
//  Created by Sergey on 20.05.2023.
//

import UIKit
import FirebaseAuth

class LogInViewController: UIViewController {
    
    private let authService = AuthService()
    
    var loginDelegate: LoginViewControllerDelegate?
    
    private let currentUser = CurrenUserService()
    private let testUserServise = TestUserService()
    
    private var coordinator: LoginCoordinatorProtocol
    
    private var isPassword = false
    
    private var timer: Timer?
    private var counter = 30
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        scrollView.showsVerticalScrollIndicator = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.backgroundColor = .createColor(lightMode: .systemMint, darkMode: .systemGray)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        
        contentView.backgroundColor = .createColor(lightMode: .systemMint, darkMode: .systemGray)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        return contentView
    }()
    
    private let logoImage: UIImageView = {
        let logo = UIImageView()
        
        logo.translatesAutoresizingMaskIntoConstraints = false
        logo.image = UIImage(named: "LogoVK")
        
        return logo
    }()
    
    private lazy var userInfo: UITextField = {
        let userInfo = UITextField()
        
        userInfo.placeholder = "Email or phone".localize
        userInfo.text = "cat"
        userInfo.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: userInfo.frame.height))
        userInfo.leftViewMode = .always
        userInfo.autocapitalizationType = .none
        userInfo.delegate = self
        
        return userInfo
    }()
    
    private lazy var userPassword: UITextField = {
        let userPassword = UITextField()
        
        userPassword.placeholder = "Password".localize
        userPassword.text = "1234"
        userPassword.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: userPassword.frame.height))
        userPassword.leftViewMode = .always
        userPassword.layer.borderWidth = 0.5
        userPassword.layer.borderColor = UIColor.black.cgColor
        userPassword.autocapitalizationType = .none
        userPassword.isSecureTextEntry = true
        userPassword.delegate = self
        
        return userPassword
    }()
    
    private lazy var stackView: UIStackView = { [unowned self] in
        let stackView = UIStackView()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.clipsToBounds = true
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 0
        stackView.backgroundColor = .createColor(lightMode: .systemMint, darkMode: .systemGray)
        stackView.layer.borderColor = UIColor.black.cgColor
        stackView.layer.borderWidth = 0.5
        stackView.layer.cornerRadius = 10
        
        stackView.addArrangedSubview(userInfo)
        stackView.addArrangedSubview(userPassword)
        
        return stackView
    }()
    
    private lazy var logIn: UIButton = {
        let button = UIButton()
        
        button.setTitle("LogIn".localize, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.setBackgroundImage(UIImage(named: "LogIn"), for: .normal)
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(pressButtonLogIn), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var enterButton: UIButton = CustomButton(
        title: "LogIn".localize,
        titleColor: .white,
        buttonColor: UIColor(patternImage: UIImage(named: "LogIn")!),
        didTapCallback: pressEnterButton
    )
    
    private lazy var passwordSelectionButton: UIButton = CustomButton(
        title: "Generate/Select password".localize,
        titleColor: .white,
        buttonColor: UIColor(patternImage: UIImage(named: "LogIn")!),
        didTapCallback: pressPasswordSelectionButton
    )
    
    private lazy var requestPushPassButton: UIButton = CustomButton(
        title: "re-send sms via:".localize,
        titleColor: .white,
        buttonColor: UIColor(patternImage: UIImage(named: "LogIn")!),
        didTapCallback: pressRequestPushPassButton
    )
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let spiner = UIActivityIndicatorView()
        
        spiner.translatesAutoresizingMaskIntoConstraints = false
        spiner.color = .magenta
        return spiner
    }()
    
    private lazy var timerLabel: UILabel = {
        let label = UILabel()
        
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        return label
    }()
    
    init (coordinator: LoginCoordinatorProtocol) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .createColor(lightMode: .systemMint, darkMode: .systemGray)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        addSubviews()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupKeyboardObservers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        removeKeyboardObservers()
    }
    
    @objc private func pressButtonLogIn() {
// временный обход регистрации
        var user = User.make()
        coordinator.switchToNextFlow(currentUser: user[1])

        authService.loginUser(email: userInfo.text!,
                              password: userPassword.text!) { [weak self] result in
            switch result {
            case .success(let user):
                self?.loginSucsess(user: user)
            case .failure:
                self?.showAddNewUser(completion: { [weak self] email, password in
                    self?.authService.signUpUser(email: email,
                                                 password: password,
                                                 completion: { user in
                        print(user)
                    })
                })
            }
        }
        passwordSelectionButton.isHidden = true
        logIn.isHidden = true
        enterButton.isHidden = false
        requestPushPassButton.isHidden = false
        timerLabel.isHidden = false
        
        self.userPassword.text = ""
        self.userPassword.placeholder = "Enter the code fron the SMS".localize
        self.userPassword.tintColor = .gray
        
        createTimerBtn()
    }

        func pressEnterButton() {
            
            guard let login = userInfo.text else {return}
            guard let password = userPassword.text else {return}
            if loginDelegate?.check(login: login, password: password) == true {
                
#if DEBUG
                guard let user = testUserServise.checkUser(login: testUserServise.user.login) else {return}
                
#else
                guard let user = currentUser.checkUser(login: userInfo.text ?? "") else {
                    Alert.shared.showAlert(title: "Cancel".localize, massage: "The user was not found".localize, viewController: self)
                    return
                }
                
#endif
                //            let profileViewController = ProfileViewController(user: user)
                //            profileViewController.title = "Профиль"
                //            self.navigationController?.pushViewController(profileViewController, animated: true)
                coordinator.switchToNextFlow(currentUser: user)
            }
            else {
                Alert.shared.showAlert(title: "Cancel".localize, massage: "Invalid username and password".localize, viewController: self)
                // end
            }
        }
//    }
    
    
    
//        @objc func pressButtonLogIn() {
//
//            guard let login = userInfo.text else {return}
//            guard let password = userPassword.text else {return}
//            if loginDelegate?.check(login: login, password: password) == true {
//
//    #if DEBUG
//                guard let user = testUserServise.checkUser(login: testUserServise.user.login) else {return}
//
//    #else
//                guard let user = currentUser.checkUser(login: userInfo.text ?? "") else {
//                    Alert.shared.showAlert(title: "Ошибка", massage: "Пользователь не найден", viewController: self)
//                    return
//                }
//
//    #endif
//    //            let profileViewController = ProfileViewController(user: user)
//    //            profileViewController.title = "Профиль"
//    //            self.navigationController?.pushViewController(profileViewController, animated: true)
//                coordinator.switchToNextFlow(currentUser: user)
//            }
//            else {
//                Alert.shared.showAlert(title: "Ошибка", massage: "Не верные имя пользователя или пароль", viewController: self)
//            }
//        }
    
    private func loginSucsess(user: FirebaseUser) {

        let user = User(login: "cat", userName: "cat", status: "your status")
        coordinator.switchToNextFlow(currentUser: user)
    }
    
    @objc func willShowKeyboard(_ notification: NSNotification) {
        let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height
        scrollView.contentInset.bottom += keyboardHeight ?? 0.0
    }
    
    @objc func willHideKeyboard(_ notification: NSNotification) {
        scrollView.contentInset.bottom = 0.0
    }
    
    @objc func pressPasswordSelectionButton() {

        activityIndicator.startAnimating()
        let newPassword = PasswordGeneration2().generationPassword(quantityPassSymbols: 3)

        DispatchQueue.global(qos: .userInitiated).async {

            print("Сгенерированный пароль:", newPassword)

            let brutForcePass = BrutForce().bruteForce(passwordToUnlock: newPassword)
            print("Подобранный пароль:", brutForcePass)

            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.userPassword.text = brutForcePass
                self.userPassword.isSecureTextEntry = false
            }
        }
    }
    
    @objc func pressRequestPushPassButton() {
        if counter == 0 {
            createTimerBtn()
        } else { return}
    }
    
    private func createTimerBtn() {
        counter = 30
        timer = Timer.scheduledTimer(
            withTimeInterval: 1.0,
            repeats: true) { [weak self] timer in
                guard let self else { return }
                self.counter -= 1
                self.timerLabel.text = self.counter <= 0 ? "" : "\(self.counter)"
                if self.counter <= 0 {
                    self.timer?.invalidate()
                    self.timer = nil
                }
            }
        //        timer?.tolerance = 0.3
    }
    
    private func setupView() {
        view.backgroundColor = .white
        navigationController?.isNavigationBarHidden = true
        requestPushPassButton.isHidden = true
        enterButton.isHidden = true
    }
    
    private func addSubviews() {
        view.addSubview(scrollView)
        
        contentView.addSubview(logoImage)
        contentView.addSubview(stackView)
        contentView.addSubview(logIn)
        contentView.addSubview(passwordSelectionButton)
        contentView.addSubview(activityIndicator)
        contentView.addSubview(timerLabel)
        contentView.addSubview(enterButton)
        contentView.addSubview(requestPushPassButton)
        scrollView.addSubview(contentView)
    }
    
    private func setupConstraints() {
        let safeAreaGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            
            scrollView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor),
            scrollView.leftAnchor.constraint(equalTo: safeAreaGuide.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: safeAreaGuide.rightAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            contentView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            
            logoImage.heightAnchor.constraint(equalToConstant: 100),
            logoImage.widthAnchor.constraint(equalToConstant: 100),
            logoImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 120),
            logoImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            stackView.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 120),
            stackView.heightAnchor.constraint(equalToConstant: 100),
            stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            stackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            
            logIn.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 16),
            logIn.heightAnchor.constraint(equalToConstant: 50),
            logIn.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            logIn.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            
            passwordSelectionButton.topAnchor.constraint(equalTo: logIn.bottomAnchor, constant: 16),
            passwordSelectionButton.heightAnchor.constraint(equalToConstant: 50),
            passwordSelectionButton.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            passwordSelectionButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -82),
            
            activityIndicator.topAnchor.constraint(equalTo: logIn.bottomAnchor, constant: 16),
            activityIndicator.heightAnchor.constraint(equalToConstant: 50),
            activityIndicator.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -41),
            
            requestPushPassButton.topAnchor.constraint(equalTo: logIn.bottomAnchor, constant: 16),
            requestPushPassButton.heightAnchor.constraint(equalToConstant: 50),
            requestPushPassButton.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            requestPushPassButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -82),
            
            timerLabel.topAnchor.constraint(equalTo: logIn.bottomAnchor, constant: 16),
            timerLabel.heightAnchor.constraint(equalToConstant: 50),
            timerLabel.leftAnchor.constraint(equalTo: requestPushPassButton.rightAnchor, constant: 8),
            timerLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            
            enterButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 16),
            enterButton.heightAnchor.constraint(equalToConstant: 50),
            enterButton.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            enterButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16)
        ])
        
        contentView.subviews.last?.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16).isActive = true
    }
    
    private func setupKeyboardObservers() {
        let notificationCenter = NotificationCenter.default
        
        notificationCenter.addObserver(
            self,
            selector: #selector(self.willShowKeyboard(_:)),
            name: UIResponder.keyboardDidShowNotification,
            object: nil
        )
        
        notificationCenter.addObserver(
            self,
            selector: #selector(self.willHideKeyboard(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
    }
    
    private func removeKeyboardObservers() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self)
    }
}

extension LogInViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(
        _ textField: UITextField
    ) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}
