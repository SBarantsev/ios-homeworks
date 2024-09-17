//
//  FeedViewController.swift
//  Navigation
//
//  Created by Sergey on 01.04.2023.
//

import UIKit

class FeedViewController: UIViewController {
    
    private var viewModel: FeedViewModelProtocol
    
    private var post = PostHeader(title: "New post")
    
    private lazy var checkGuessTextField: UITextField = {
        
        let textField = UITextField()
        textField.backgroundColor = .lightGray
        textField.placeholder = "Введите секретное слово: secret"
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.textColor = .gray
        textField.autocapitalizationType = .none
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    private lazy var checkGuessButton: UIButton = CustomButton(
        title: "Checking the code word".localize,
        titleColor: .black,
        buttonColor: .lightGray,
        didTapCallback: pressButton
    )
    
    private lazy var CheckLabel: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .lightGray
        
        return label
    }()
    
    private lazy var actionButton1: UIButton = CustomButton(
        title: "Button 1",
        titleColor: .black,
        buttonColor: .systemMint,
        didTapCallback: pressButton1
    )
    
    @objc private func pressButton1 () {
        print("touch button1")
        viewModel.pushInfoViewController()
//        let postViewController = PostViewController()
//        postViewController.title = post.title
//        self.navigationController?.pushViewController(postViewController, animated: true)
    }
    
    private lazy var actionButton2: UIButton = CustomButton(
        title: "Go to post and info view".localize,
        titleColor: .black,
        buttonColor: .systemBlue,
        didTapCallback: pressButton2
    )
    
    @objc private func pressButton2 () {
        
        let postViewController = PostViewController()
        postViewController.title = post.title
        self.navigationController?.pushViewController(postViewController, animated: true)
    }
    
    private lazy var stackView: UIStackView = { [unowned self] in
        let stackView = UIStackView()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.clipsToBounds = true
        
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 10
        
        stackView.addArrangedSubview(actionButton1)
        stackView.addArrangedSubview(actionButton2)
        stackView.addArrangedSubview(checkGuessTextField)
        stackView.addArrangedSubview(checkGuessButton)
        stackView.addArrangedSubview(CheckLabel)
        
        return stackView
    }()
    
    private func pressButton() {
        
        guard let word = checkGuessTextField.text else {return}
        print(word)
        viewModel.tapButton(word)
    }
    
    // MARK: - Init
    
    init(viewModel: FeedViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .createColor(lightMode: .systemMint, darkMode: .systemGray)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemYellow
        view.addSubview(stackView)
        
        setupConstraints()
        bindViewModel()
        actionButton1.isHidden = true
    }
    
    private func bindViewModel() {
        viewModel.handleState = { [weak self] state in
            guard let self = self else {return}
            
            switch state {
            case .checkWord:
                print("Идет проверка секретного слова")
            case .wordTrue:
                self.CheckLabel.backgroundColor = .green
            case .wordFalse:
                self.CheckLabel.backgroundColor = .red
            }
        }
    }
    
    private func setupConstraints() {
        
        let safeAreaGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: safeAreaGuide.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: safeAreaGuide.centerYAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 250),
            stackView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor, constant: -20)
        ])
    }
}
