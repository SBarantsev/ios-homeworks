//
//  FeedCoordinator.swift
//  Navigation
//
//  Created by Sergey on 03.12.2023.
//

import UIKit

protocol FeedCoordinatroProtocol: AnyObject {
    
}

class FeedCoordinator {
    
    var parentCoordinator: TabBarCoordinatorProtocol?
    lazy var rootViewController: UIViewController = UIViewController()
}

extension FeedCoordinator: CoordinatorProtocol {
    func start() -> UIViewController {
        let viewModel = FeedViewModel()
        let feedViewController = FeedViewController(viewModel: viewModel)
        feedViewController.title = "Лента"
        feedViewController.tabBarItem = UITabBarItem(
            title: "Лента",
            image: UIImage(systemName: "house"),
            tag: 0
        )
        return feedViewController
    }
}


