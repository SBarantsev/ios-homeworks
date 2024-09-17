//
//  HeaderTableView.swift
//  Navigation
//
//  Created by Sergey on 11.07.2023.
//

import UIKit

class HeaderTableVIew: UIView {
    
    var onButtonTapped: (() -> Void)?
    
    private var statusText: String = ""
    
    private let photoImageView: UIImageView = {
        
        let imageView = UIImageView()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .systemBlue
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.cornerRadius = 60
        imageView.image = UIImage(named: "Avatar")
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    let nameLabel: UILabel = {
        
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Happy Giraffe"
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .black
        
        return label
    }()
    
    private let statusViews: UITextField = {
        
        let status = UITextField()
        
        status.translatesAutoresizingMaskIntoConstraints = false
        status.text = "Waiting for something..."
        status.font = .systemFont(ofSize: 14)
        status.textColor = .gray
        
        return status
    }()
    
    private lazy var enterStatusViews: UITextField = {
        
        let enterStatus = UITextField()
        
        enterStatus.translatesAutoresizingMaskIntoConstraints = false
        enterStatus.backgroundColor = .white
        enterStatus.placeholder = statusText
        enterStatus.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: enterStatus.frame.height))
        enterStatus.leftViewMode = .always
        enterStatus.font = .systemFont(ofSize: 15)
        enterStatus.textColor = .black
        enterStatus.layer.borderWidth = 1
        enterStatus.layer.borderColor = UIColor.black.cgColor
        enterStatus.layer.cornerRadius = 12
        enterStatus.addTarget(self, action: #selector(statusTextChange), for: .editingChanged)
        
        return enterStatus
    }()
    
    private lazy var statusButton: UIButton = {
        
        let button = CustomButton(
            title: "Show status".localize,
            titleColor: .white,
            buttonColor: .systemBlue,
            didTapCallback: pressButton
        )
        
        return button
    }()
    
    lazy var navigationButton: UIButton = {
       
        let button = UIButton()
        button.setImage(UIImage(systemName: "location.fill"), for: .normal)
        button.tintColor = .systemBlue
        button.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(pressNavigationButton), for: .touchUpInside)
        
        return button
    }()
    
    private func pressButton() {
        print(statusViews.text!)
        statusViews.text = statusText
    }
    
    @objc private func statusTextChange(_ textField: UITextField) {
        self.statusText = enterStatusViews.text!
    }
    
    @objc private func pressNavigationButton() {
        onButtonTapped?()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.statusText = "Waiting for something..."
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(photoImageView)
        addSubview(nameLabel)
        addSubview(statusViews)
        addSubview(statusButton)
        addSubview(enterStatusViews)
        addSubview(navigationButton)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            photoImageView.heightAnchor.constraint(equalToConstant: 120),
            photoImageView.widthAnchor.constraint(equalToConstant: 120),
            photoImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            photoImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 27),
            nameLabel.heightAnchor.constraint(equalToConstant: 18),
            nameLabel.leftAnchor.constraint(equalTo: photoImageView.rightAnchor, constant: 20),
            nameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -48),
            
            statusButton.heightAnchor.constraint(equalToConstant: 50),
            statusButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            statusButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            statusButton.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 50),
            statusButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            
            statusViews.bottomAnchor.constraint(equalTo: enterStatusViews.topAnchor, constant: -16),
            statusViews.heightAnchor.constraint(equalToConstant: 14),
            statusViews.leftAnchor.constraint(equalTo: photoImageView.rightAnchor, constant: 20),
            statusViews.rightAnchor.constraint(equalTo: rightAnchor, constant: -8),
            
            enterStatusViews.bottomAnchor.constraint(equalTo: statusButton.topAnchor, constant: -34),
            enterStatusViews.heightAnchor.constraint(equalToConstant: 40),
            enterStatusViews.leftAnchor.constraint(equalTo: photoImageView.rightAnchor, constant: 20),
            enterStatusViews.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            
            navigationButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            navigationButton.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
        ])
    }
    
    func update(user: User) {
        nameLabel.text = user.userName
        statusViews.text = user.status
        photoImageView.image = user.avatar
    }
}

