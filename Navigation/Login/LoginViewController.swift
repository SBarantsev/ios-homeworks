//
//  LoginViewController.swift
//  Navigation
//
//  Created by Sergey on 20.05.2023.
//

import UIKit

class LogInViewController: UIViewController {
    
    var loginDelegate: LoginViewControllerDelegate?
    
    private let currentUser = CurrenUserService()
    private let testUserServise = TestUserService()
    
    private var coordinator: LoginCoordinatorProtocol
    
    private var isPassword = false
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        scrollView.showsVerticalScrollIndicator = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.backgroundColor = .white
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        
        contentView.backgroundColor = .white
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
        
        userInfo.placeholder = "Email or phone"
        userInfo.text = "cat"
        userInfo.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: userInfo.frame.height))
        userInfo.leftViewMode = .always
        userInfo.autocapitalizationType = .none
        userInfo.delegate = self
        
        return userInfo
    }()
    
    private lazy var userPassword: UITextField = {
        let userPassword = UITextField()
        
        userPassword.placeholder = "Password"
        userPassword.text = "1234"
        userPassword.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: userPassword.frame.height))
        userPassword.leftViewMode = .always
        userPassword.layer.borderWidth = 0.5
        userPassword.layer.borderColor = UIColor.lightGray.cgColor
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
        stackView.backgroundColor = .systemGray6
        stackView.layer.borderColor = UIColor.lightGray.cgColor
        stackView.layer.borderWidth = 0.5
        stackView.layer.cornerRadius = 10
        
        stackView.addArrangedSubview(userInfo)
        stackView.addArrangedSubview(userPassword)
        
        return stackView
    }()
    
    private lazy var logIn: UIButton = {
        let button = UIButton()
        
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.setBackgroundImage(UIImage(named: "LogIn"), for: .normal)
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(pressButtonLogIn), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var passwordSelectionButton: UIButton = CustomButton(
        title: "Cгенерировать/подобрать пароль",
        titleColor: .cyan,
        buttonColor: UIColor(patternImage: UIImage(named: "LogIn")!),
        didTapCallback: pressPasswordSelectionButton
    )
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let spiner = UIActivityIndicatorView()
        
        spiner.translatesAutoresizingMaskIntoConstraints = false
        spiner.color = .magenta
        return spiner
    }()
    
    init (coordinator: LoginCoordinatorProtocol) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
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
    
    @objc func pressButtonLogIn() {
        
        guard let login = userInfo.text else {return}
        guard let password = userPassword.text else {return}
        if loginDelegate?.check(login: login, password: password) == true {
            
#if DEBUG
            guard let user = testUserServise.checkUser(login: testUserServise.user.login) else {return}
            
#else
            guard let user = currentUser.checkUser(login: userInfo.text ?? "") else {
                Alert.shared.showAlert(title: "Ошибка", massage: "Пользователь не найден", viewController: self)
                return
            }
            
#endif
            //            let profileViewController = ProfileViewController(user: user)
            //            profileViewController.title = "Профиль"
            //            self.navigationController?.pushViewController(profileViewController, animated: true)
            coordinator.switchToNextFlow(currentUser: user)
        }
        else {
            Alert.shared.showAlert(title: "Ошибка", massage: "Не верные имя пользователя или пароль", viewController: self)
        }
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
        let newPassword = PasswordSelection().generationPassword(quantityPassSymbols: 5)
        
        DispatchQueue.global(qos: .background).async {
            
            print("Сгенерированный пароль:", newPassword)
            let brutForcePass = PasswordSelection().brutForce(pass: newPassword)
            print("Подобранный пароль:", brutForcePass)
            
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.userPassword.text = brutForcePass
                self.userPassword.isSecureTextEntry = false
            }
        }
    }
    
    private func setupView() {
        view.backgroundColor = .white
        navigationController?.isNavigationBarHidden = true
    }
    
    private func addSubviews() {
        view.addSubview(scrollView)
        
        scrollView.addSubview(contentView)
        
        contentView.addSubview(logoImage)
        contentView.addSubview(stackView)
        contentView.addSubview(logIn)
        contentView.addSubview(passwordSelectionButton)
        contentView.addSubview(activityIndicator)
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
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
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
            activityIndicator.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -41)
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
