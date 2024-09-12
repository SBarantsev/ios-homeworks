//
//  PostViewController.swift
//  Navigation
//
//  Created by Sergey on 01.04.2023.
//

import UIKit

class PostViewController: UIViewController {
    
    private let network = NetworkService2()
    
    private func setupView() {
        view.backgroundColor = .systemPurple
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Info", style: .plain, target: self, action: #selector(pressButton))
    }

    @objc private func pressButton () {
        
        let infoViewController = InfoViewController()
        
        infoViewController.modalTransitionStyle = .flipHorizontal
        infoViewController.modalPresentationStyle = .pageSheet
        present(infoViewController, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()

    }
}
