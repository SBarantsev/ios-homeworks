//
//  LoginFactory.swift
//  Navigation
//
//  Created by Sergey on 09.11.2023.
//

import UIKit


protocol LoginFactory {
    func makeLoginInspector() -> LoginInspector
}

struct MyLoginFactory: LoginFactory {
    func makeLoginInspector() -> LoginInspector {
        return LoginInspector()
    }
}
