//
//  CheckerService.swift
//  Navigation
//
//  Created by Sergey on 08.04.2024.
//

import Foundation
import FirebaseAuth

final class CheckerService: CheckerServiceProtocol {
    func checkCredentials(email: String, password: String, completion: @escaping (User?, _ error: String?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error {
                print(error.localizedDescription)
                completion(nil, error.localizedDescription)
            }
            guard let user = authResult?.user else {
                completion(nil, error?.localizedDescription)
                return
            }
            
            _ = User(login: user.email!,
                               userName: user.displayName!,
                     status: "Update status".localize
            )
        }
    }
    
    func signUp(email: String, password: String, completion: @escaping (Bool, _ error: String?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print(error.localizedDescription)
            }
            else {
                completion(true, nil)
            }
        }
    }
}

protocol CheckerServiceProtocol {
    
    func checkCredentials(email: String, password: String, completion: @escaping (User?, _ error: String?) -> Void)
    
    func signUp(email: String, password: String, completion: @escaping (Bool, _ error: String?) -> Void)
}

