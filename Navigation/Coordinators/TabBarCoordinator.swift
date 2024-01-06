//
//  TabBarCoordinator.swift
//  Navigation
//
//  Created by Sergey on 09.12.2023.
//

import Foundation
import UIKit

protocol TabBarCoordinatorProtocol: AnyObject {
    
}

final class TabBarCoordinator {
    var childCoordinators: [CoordinatorProtocol] = []
    private var tabBarController: UITabBarController
    private var parentCoordinator: MainCoordinatorProtocol?
    
    private let currentUser: User
    
    init(tabBarController: UITabBarController,
         parentCoordinator: MainCoordinatorProtocol?,
         currentUser: User
    ) {
        self.tabBarController = tabBarController
        self.parentCoordinator = parentCoordinator
        self.currentUser = currentUser
    }
    
    private func addChildCoordinator(coordinator: CoordinatorProtocol) {
        guard !self.childCoordinators.contains(where: {$0 === coordinator}) else {return}
        childCoordinators.append(coordinator)
    }
    
    private func removeChildCoordinator(coordinator: CoordinatorProtocol) {
        childCoordinators.removeAll(where: {$0 === coordinator})
    }
}

extension TabBarCoordinator: CoordinatorProtocol {
    func start() -> UIViewController {
        let tabBarController = UITabBarController()
        let feedCoordinator = FeedCoordinator()
        let profileCoordinator = ProfileCoordinator(
            parentCoordinator: self,
            navController: UINavigationController(),
            currentUser: currentUser)
        
        let controllers = [feedCoordinator.start(), profileCoordinator.start()]
        tabBarController.viewControllers = controllers
        self.tabBarController = tabBarController
        return self.tabBarController
    }
}

extension TabBarCoordinator: TabBarCoordinatorProtocol {
    
}
