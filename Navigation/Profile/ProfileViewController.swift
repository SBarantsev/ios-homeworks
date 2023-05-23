//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Sergey on 01.04.2023.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private var profileHeaderView: ProfileHeaderView = {
      
        let headerView = ProfileHeaderView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        return headerView
    }()
    
    private lazy var titleButton: UIButton = {

        let button = UIButton()

        button.setTitle("Change title", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .systemMint
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(pressTitleButton), for: .touchUpInside)
        
        return button
    }()
    
    @objc private func pressTitleButton () {
        title = profileHeaderView.nameLabel.text
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        view.addSubview(profileHeaderView)
        view.addSubview(titleButton)
        viewConstraints()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
     private func viewConstraints() {
        let safeAreaGuide = view.safeAreaLayoutGuide
        
         NSLayoutConstraint.activate([
            profileHeaderView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            profileHeaderView.leftAnchor.constraint(equalTo: safeAreaGuide.leftAnchor),
            profileHeaderView.rightAnchor.constraint(equalTo: safeAreaGuide.rightAnchor),
            profileHeaderView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor),
            
            titleButton.heightAnchor.constraint(equalToConstant: 40),
            titleButton.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor),
            titleButton.leftAnchor.constraint(equalTo: safeAreaGuide.leftAnchor),
            titleButton.rightAnchor.constraint(equalTo: safeAreaGuide.rightAnchor)
                ])
            }
}
