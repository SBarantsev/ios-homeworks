//
//  UIViewController+Extension.swift
//  Navigation
//
//  Created by Sergey on 10.04.2024.
//

import Foundation
import UIKit

extension UIViewController {
    func showAlert() {
        let alertViewController = UIAlertController(title: "Cancel".localize,
                                                    message: "Try again".localize,
                                                    preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Ok",
                                   style: .default)
        alertViewController.addAction(action)
        present(alertViewController, animated: true)
    }
    
    func showAddNewUser(completion: @escaping (String, String) -> Void) {
        let alertViewController = UIAlertController(
            title: "The user's data was not found, please try again".localize,
            message: "To registrater a new user, enter your email and password".localize,
            preferredStyle: .alert
        )
        alertViewController.addTextField()
        alertViewController.addTextField()
        alertViewController.textFields?[1].isSecureTextEntry = true
        
        let okAction = UIAlertAction(title: "Ok",
                                     style: .default) { _ in
            guard let email = alertViewController.textFields?[0].text, email != "",
                  let password = alertViewController.textFields?[1].text, password != "" else { return }
            
            completion(email, password)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel".localize, style: .cancel)
        
        alertViewController.addAction(okAction)
        alertViewController.addAction(cancelAction)
        
        present(alertViewController, animated: true)
    }
}
