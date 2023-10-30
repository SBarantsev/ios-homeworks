//
//  HeaderTableView.swift
//  Navigation
//
//  Created by Sergey on 11.07.2023.
//

import UIKit
import SnapKit

class HeaderTableVIew: UIView {
    
    private var statusText: String = ""
    
    private let photoImageView: UIImageView = {
        
        let imageView = UIImageView()
        
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
        
        label.text = "Happy Giraffe"
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .black
        
        return label
    }()
    
    private let statusViews: UITextField = {
        
        let status = UITextField()
        
        status.text = "Waiting for something..."
        status.font = .systemFont(ofSize: 14)
        status.textColor = .gray
        
        return status
    }()
    
    private lazy var enterStatusViews: UITextField = {
        
        let enterStatus = UITextField()
        
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
        
        let button = UIButton()
        
        button.setTitle("Show status", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 4
        button.layer.masksToBounds = false
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        button.addTarget(self, action: #selector(pressButton), for: .touchUpInside)
        
        return button
    }()
    
    @objc private func pressButton (){
        print(statusViews.text!)
        statusViews.text = statusText
    }
    
    @objc private func statusTextChange(_ textField: UITextField) {
        self.statusText = enterStatusViews.text!
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
    }
    
    private func setupConstraints() {
        
        photoImageView.snp.makeConstraints { make in
            make.width.height.equalTo(120)
            make.top.left.equalTo(16)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(27)
            make.height.equalTo(18)
            make.left.equalTo(photoImageView.snp_rightMargin).offset(20)
            make.right.equalTo(-16)
        }
        
        statusButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.right.equalTo(-16)
            make.left.equalTo(16)
            make.top.equalTo(photoImageView.snp_bottomMargin).offset(50)
            make.bottom.equalTo(-16)
        }
        
        statusViews.snp.makeConstraints { make in
            make.height.equalTo(14)
            make.left.equalTo(photoImageView.snp_rightMargin).offset(20)
            make.right.equalTo(-8)
            make.bottom.equalTo(enterStatusViews.snp_topMargin).offset(-16)
        }
        
        enterStatusViews.snp.makeConstraints { make in
            make.bottom.equalTo(statusButton.snp_topMargin).offset(-34)
            make.height.equalTo(40)
            make.left.equalTo(photoImageView.snp_rightMargin).offset(20)
            make.right.equalTo(-16)
        }
    }
}

