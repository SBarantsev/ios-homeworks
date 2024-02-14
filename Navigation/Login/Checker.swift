//
//  Checker.swift
//  Navigation
//
//  Created by Sergey on 06.11.2023.
//

import UIKit

final class Checker {
    
    static let shared = Checker()
    
    private let login: String = "cat"
    private let password: String = "1234"
    
    private init() {}
    
    func chek(log: String, pass: String) -> Bool {
        log == login && pass == password
    }
}

protocol LoginViewControllerDelegate {
    func check(login: String, password: String) -> Bool
}

struct LoginInspector: LoginViewControllerDelegate {
    func check(login: String, password: String) -> Bool {
        Checker.shared.chek(log: login, pass: password)
    }
}

final class Alert: NSObject {
    
    static let shared = Alert()
    
    private override init() {}
    
    func showAlert(title: String, massage: String, viewController: UIViewController) {
        let alert = UIAlertController(title: title, message: massage, preferredStyle: .alert)
        
        viewController.present(alert, animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
            alert.dismiss(animated: true)
        }
    }
}

