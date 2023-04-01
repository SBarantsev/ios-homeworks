//
//  FeedViewController.swift
//  Navigation
//
//  Created by Sergey on 01.04.2023.
//

import UIKit

class FeedViewController: UIViewController {
    
    var post = Post(title: "New post")
    
    private lazy var actionButton: UIButton = {
        
        let button = UIButton()
        
        button.setTitle("show post", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.frame = CGRect(x: 100, y: 200, width: 200, height: 50)
        
        button.addTarget(self, action: #selector(pressButton), for: .touchUpInside)
        
        return button
    }()
    
    @objc private func pressButton () {
        
        let postViewController = PostViewController()
        postViewController.title = post.title
        self.navigationController?.pushViewController(postViewController, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemYellow
        view.addSubview(actionButton)
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
