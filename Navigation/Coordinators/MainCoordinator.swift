//
//  MainCoordinator.swift
//  Navigation
//
//  Created by Sergey on 04.12.2023.
//

import UIKit

protocol MainCoordinatorProtocol: AnyObject {
    func switchToNextFlow(currentCoordinator: CoordinatorProtocol, currentUser: User)
}

class MainCoordinator {
    
    private var rootViewController: UIViewController
    
    private var childCoordinators: [CoordinatorProtocol] = []
    
    init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
    }
    
    private func setLoginCoordinator() -> CoordinatorProtocol {
        let loginCoordinator = LoginCoordinator(parentCoordinator: self, navigationController: UINavigationController())
        
        return loginCoordinator
    }
    
    private func setTabBarCoordinator(currentUser: User) -> CoordinatorProtocol {
        let tabBarCoordinator = TabBarCoordinator(tabBarController: UITabBarController(), parentCoordinator: self, currentUser: currentUser)
        return tabBarCoordinator
    }
    
    private func addChildCoordinator(coordinator: CoordinatorProtocol) {
        guard !self.childCoordinators.contains(where: {$0 === coordinator}) else {return}
        childCoordinators.append(coordinator)
    }
    
    private func removeChildCoordinator(coordinator: CoordinatorProtocol) {
        childCoordinators.removeAll(where: {$0 === coordinator})
    }
    
    private func setFlow(to newViewController: UIViewController) {
        rootViewController.addChild(newViewController)
        newViewController.view.frame = rootViewController.view.frame
        rootViewController.view.addSubview(newViewController.view)
        newViewController.didMove(toParent: rootViewController)
    }
    
    private func switchFlow(to newViewController: UIViewController) {
        rootViewController.children[0].willMove(toParent: nil)
        rootViewController.children[0].navigationController?.isNavigationBarHidden = true
        rootViewController.addChild(newViewController)
        newViewController.view.frame = rootViewController.view.bounds
        
        rootViewController.transition(
            from: rootViewController.children[0],
            to: newViewController,
            duration: 0.6,
            options: [.transitionCrossDissolve, .curveEaseOut],
            animations: {}
        ) {_ in
            self.rootViewController.children[0].removeFromParent()
            newViewController.didMove(toParent: self.rootViewController)
        }
    }
    
    private func switchCoordinators(from oldCoordinator: CoordinatorProtocol, to newCoordinator: CoordinatorProtocol) {
        addChildCoordinator(coordinator: newCoordinator)
        switchFlow(to: newCoordinator.start())
        removeChildCoordinator(coordinator: oldCoordinator)
    }
}

extension MainCoordinator: CoordinatorProtocol {
    
    func start() -> UIViewController {
        
        var coordinator: CoordinatorProtocol
        coordinator = setLoginCoordinator()
        
        addChildCoordinator(coordinator: coordinator)
        setFlow(to: coordinator.start())
        return rootViewController
    }
}

extension MainCoordinator: MainCoordinatorProtocol {
    func switchToNextFlow(currentCoordinator: CoordinatorProtocol, currentUser: User) {
         switch currentCoordinator {

         case let oldCoordinator as LoginCoordinator:
             let newCoordinator = self.setTabBarCoordinator(currentUser: currentUser)
             self.switchCoordinators(from: oldCoordinator, to: newCoordinator)

         case let oldCoordinator as TabBarCoordinator:
             let newCoordinator = self.setLoginCoordinator()
             self.switchCoordinators(from: oldCoordinator, to: newCoordinator)

         default:
             print("Ошибка! func switchToNextFlow in MainCoordinator")
         }
     }
}
