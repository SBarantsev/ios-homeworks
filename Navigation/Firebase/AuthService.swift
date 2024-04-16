//
//  AuthService.swift
//  Navigation
//
//  Created by Sergey on 07.04.2024.
//

import FirebaseAuth

final class AuthService {
    func signUpUser(email: String,
                    password: String,
                    completion: @escaping (Result<Navigation.User, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
                print(error.localizedDescription)
            }
            
            if let authResult = authResult {
                let firebaseUser = Navigation.User(login: authResult.user.displayName ?? "",
                                                   userName: authResult.description,
                                                   status: "")
                completion(.success(firebaseUser))
            }
        }
    }
    
    func loginUser(email: String, password: String, completion: @escaping (Result<FirebaseUser, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
                print(error.localizedDescription)
            }
            
            if let authResult = authResult {
                print(authResult)
                
                let user = User(login: authResult.description,
                                userName: authResult.description,
                                status: "")
                let firebaseUser = FirebaseUser(user: user)
                completion(.success(firebaseUser))
            }
        }
    }
    
    func logoutUser(completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(.success(()))
        } catch {
            completion(.failure(error))
        }
    }
}

