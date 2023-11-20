//
//  FeedViewController.swift
//  Navigation
//
//  Created by Sergey on 01.04.2023.
//

import UIKit

class FeedViewController: UIViewController {
    
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
    
    private lazy var checkGuessButton: CustomButton = {
        
        let button = CustomButton(
            title: "Проверка кодового слова",
            titleColor: .black,
            buttonColor: .lightGray,
            didTapCallback: pressButton
        )
        
        return button
    }()
    
    private lazy var CheckLabel: UILabel = {
       
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .lightGray
        
        return label
    }()
    
    private lazy var actionButton1: UIButton = {
       
        let button = CustomButton(
            title: "Button 1",
            titleColor: .black,
            buttonColor: .systemMint,
            didTapCallback: pressButton1
        )
        
        return button
    }()
    
    @objc private func pressButton1 () {
        let postViewController = PostViewController()
        postViewController.title = post.title
        self.navigationController?.pushViewController(postViewController, animated: true)
    }
    
    private lazy var actionButton2: UIButton = {
        
        let button = CustomButton(
            title: "Button 2",
            titleColor: .black,
            buttonColor: .systemBlue,
            didTapCallback: pressButton2
        )

       return button
    }()
    
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
        let checkWord = FeedModel()
        let checkResult = checkWord.check(word: word)
        if checkResult == true {
            CheckLabel.backgroundColor = .green
        } else {
            CheckLabel.backgroundColor = .red
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemYellow
        view.addSubview(stackView)
        
        setupConstraints()
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
