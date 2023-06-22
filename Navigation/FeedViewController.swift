//
//  FeedViewController.swift
//  Navigation
//
//  Created by Sergey on 01.04.2023.
//

import UIKit

class FeedViewController: UIViewController {
    
    private var post = PostHeader(title: "New post")
    
    private lazy var actionButton1: UIButton = {
       
        let button = UIButton()
        
        button.setTitle("Button 1", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .systemMint
        button.addTarget(self, action: #selector(pressButton1), for: .touchUpInside)
        
        return button
    }()
    
    @objc private func pressButton1 () {
        let postViewController = PostViewController()
        postViewController.title = post.title
        self.navigationController?.pushViewController(postViewController, animated: true)
    }
    
    private lazy var actionButton2: UIButton = {
        
        let button = UIButton()
        
        button.setTitle("Button 2", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .systemBlue
        button.frame = CGRect(x: 100, y: 200, width: 200, height: 50)
        button.addTarget(self, action: #selector(pressButton2), for: .touchUpInside)
        
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
        
        return stackView
    }()
    
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
            stackView.heightAnchor.constraint(equalToConstant: 100),
            stackView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor, constant: -20)
            ])
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
