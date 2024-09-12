//
//  CustomButton.swift
//  Navigation
//
//  Created by Sergey on 15.11.2023.
//

import UIKit

class CustomButton: UIButton {
    
    var didTapCallback: (() -> Void)
    
    init (
        title: String,
        titleColor: UIColor,
        buttonColor: UIColor,
        didTapCallback: @escaping() -> Void
    ) {
        self.didTapCallback = didTapCallback
        super.init(frame: .zero)
        
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.backgroundColor = buttonColor
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        self.layer.cornerRadius = 4
        self.layer.masksToBounds = false
        self.layer.shadowOffset = CGSize(width: 4, height: 4)
        self.layer.shadowRadius = 4
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.7
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func buttonTapped() {
        didTapCallback()
    }
}
