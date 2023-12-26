//
//  LoginCoordinator.swift
//  Navigation
//
//  Created by Sergey on 04.12.2023.
//

import UIKit

protocol LoginCoordinatorProtocol {
    func switchToNextFlow(currentUser: User)
}

class LoginCoordinator {
    
    weak var parentCoordinator: MainCoordinatorProtocol?
    private var navigationController: UINavigationController
    
    init(parentCoordinator: MainCoordinatorProtocol?,
         navigationController: UINavigationController) {
        self.parentCoordinator = parentCoordinator
        self.navigationController = navigationController
    }
}

extension LoginCoordinator: CoordinatorProtocol {
    func start() -> UIViewController {
        let loginFactory = MyLoginFactory().makeLoginInspector()
        let loginViewController = LogInViewController(coordinator: self)
        loginViewController.loginDelegate = loginFactory
        let navController = UINavigationController(rootViewController: loginViewController)
        self.navigationController = navController
        return navigationController
    }
}

extension LoginCoordinator: LoginCoordinatorProtocol {
    func switchToNextFlow(currentUser: User) {
        parentCoordinator?.switchToNextFlow(currentCoordinator: self,
                                            currentUser: currentUser
        )
    }    
}
