//
//  FeedCoordinator.swift
//  Navigation
//
//  Created by Sergey on 03.12.2023.
//

import UIKit

protocol FeedCoordinatorProtocol {
    func pushInfoViewController()
}

final class FeedCoordinator {
    
//    var parentCoordinator: TabBarCoordinatorProtocol?
//    lazy var rootViewController: UIViewController = UIViewController()
//
    private var navigationController = UINavigationController()
    private weak var parentCoordinator: TabBarCoordinatorProtocol?
    
    init(navigationController: UINavigationController, parentCoordinator: TabBarCoordinatorProtocol?) {
        self.navigationController = navigationController
        self.parentCoordinator = parentCoordinator
    }
}

extension FeedCoordinator: CoordinatorProtocol {
    func start() -> UIViewController {
//        let feedModel = FeedModel()
        let feedViewModel = FeedViewModel(coordinator: self)
        let feedViewController = FeedViewController(viewModel: feedViewModel)
        let navController = UINavigationController(rootViewController: feedViewController)
        
        navController.tabBarItem = UITabBarItem(
            title: "Feed".localize,
            image: UIImage(systemName: "house"),
            tag: 0
        )
        
//        feedViewController.title = "Лента"
//        feedViewController.tabBarItem = UITabBarItem(
//            title: "Лента",
//            image: UIImage(systemName: "house"),
//            tag: 0
//        )
        return navController
    }
}

extension FeedCoordinator: FeedCoordinatorProtocol {
    func pushInfoViewController() {
        let infoViewController = PostViewController()
        navigationController.pushViewController(infoViewController, animated: true)
    }
}


