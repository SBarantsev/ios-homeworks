//
//  Checker.swift
//  Navigation
//
//  Created by Sergey on 06.11.2023.
//

import UIKit

final class Checker {
    
    static let shared = Checker()
    
    private let login: String = "111"
    private let password: String = "222"
    
    private init() {}
    
    func chek(log: String, pass: String) -> Bool {

        let login = login
        let pass = password

        if log == login && pass == password {
            return true
        } else {return false}
    }
}

protocol LoginViewControllerDelegate {
    func check(login: String, password: String) -> Bool
}


//extension Checker: LoginViewControllerDelegate{
//    func check(login: String, password: String) -> Bool {
//        <#code#>
//    }
//
//
//}

struct LoginInspector: LoginViewControllerDelegate {
    func check(login: String, password: String) -> Bool {
        Checker.shared.chek(log: login, pass: password)
    }
    
    
}
