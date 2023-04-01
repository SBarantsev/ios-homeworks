//
//  InfoViewController.swift
//  Navigation
//
//  Created by Sergey on 01.04.2023.
//

import UIKit

class InfoViewController: UIViewController {
    
    private lazy var actionButton: UIButton = {
        
        let button = UIButton()
        
        button.setTitle("Open", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.frame = CGRect(x: 100, y: 200, width: 200, height: 50)
        
        button.addTarget(self, action: #selector(pressButton), for: .touchUpInside)
        
        return button
    }()
    
    @objc private func pressButton () {
        let alert = UIAlertController(title: "Hello", message: "Check updates?", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Yes", style: .default) {
            UIAlertAction in
            NSLog("Check updates")
        }
        
        let cancelAction = UIAlertAction(title: "No", style: .default) {
            UIAlertAction in
            NSLog("Check updates later")
        }
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBlue
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
