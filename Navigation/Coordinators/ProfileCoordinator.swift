//
//  ProfileCoordinator.swift
//  Navigation
//
//  Created by Sergey on 03.12.2023.
//

import UIKit

protocol ProfileCoordinatorProtocol: AnyObject {
    func pushFotos()
}

class ProfileCoordinator {
   
    weak var parentCoordinator: TabBarCoordinatorProtocol?
    private var navController: UINavigationController
    
    private var currentUser: User
   
    init(parentCoordinator: TabBarCoordinatorProtocol?,
         navigationController: UINavigationController,
         currentUser: User
    ) {
        self.parentCoordinator = parentCoordinator
        self.navController = navigationController
        self.currentUser = currentUser
    }
}

extension ProfileCoordinator: CoordinatorProtocol {
    
    func start() -> UIViewController {
        let model = ProfileModel(user: currentUser)
        let viewModel = ProfileViewModel(coordinator: self, model: model)
        let viewController = ProfileViewController(viewModel: viewModel)
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem = UITabBarItem(
            title: "Профиль",
            image: UIImage(systemName: "person.circle"),
            tag: 1
        )
        self.navController = navController
        
        return self.navController
    }
}

extension ProfileCoordinator: ProfileCoordinatorProtocol {
    func pushFotos() {
        let photoViewController = PhotosViewController()
        navController.pushViewController(photoViewController, animated: true)
    }
}
