//
//  InfoViewController.swift
//  Navigation
//
//  Created by Sergey on 01.04.2023.
//

import UIKit

class InfoViewController: UIViewController {
    
    private let network = NetworkService2()
    
    private lazy var actionButton: UIButton = {
        
        let button = UIButton()
        
        button.setTitle("Open", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.frame = CGRect(x: 100, y: 200, width: 200, height: 50)
        
        button.addTarget(self, action: #selector(pressButton), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var urlLabel: UILabel = {
       let label = UILabel()
        label.text = "no data"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var planetLabel: UILabel = {
       let label = UILabel()
        label.text = "no data"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
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
        view.addSubview(urlLabel)
        view.addSubview(planetLabel)
        
        network.getRequest(completion: {title in
            DispatchQueue.main.async {
                self.urlLabel.text = "Title: " + title
            }
        })
        
        network.getRequestOrbitalPeriod(completion: {orbitalPeriod in
            DispatchQueue.main.async {
                self.planetLabel.text = "Период обращения планеты: " + orbitalPeriod
            }
        })

        NSLayoutConstraint.activate([
            
            urlLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            urlLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            planetLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            planetLabel.topAnchor.constraint(equalTo: urlLabel.bottomAnchor, constant: 20)
            
        ])
    }
    
    
}
