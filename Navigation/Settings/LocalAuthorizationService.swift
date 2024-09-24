//
//  LocalAuthorizationService.swift
//  Navigation
//
//  Created by Sergey on 23.09.2024.
//

import Foundation
import LocalAuthentication

class LocalAuthorizationService {
    
    static let shared = LocalAuthorizationService()
    
    func authorizeIfPossible(_ authorizationFinished: @escaping (Result<Bool, Error>) -> Void) {
        var error: NSError?
        guard LAContext().canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
            authorizationFinished(.failure(error ?? NSError()))
            return
        }
        LAContext().evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Authorization".localize) { result, error in
            if let error = error {
                authorizationFinished(.failure(error))
            } else {
                authorizationFinished(.success(result))
            }
        }
    }
}
