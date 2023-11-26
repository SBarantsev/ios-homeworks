//
//  SceneDelegate.swift
//  Navigation
//
//  Created by Sergey on 01.04.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let scene = (scene as? UIWindowScene) else { return }
    
        let window = UIWindow(windowScene: scene)
       
        func createFeedViewController() -> UINavigationController {
            
            let viewModel = FeedViewModel()
            let feedViewController = FeedViewController(viewModel: viewModel)
            feedViewController.title = "Лента"
            feedViewController.tabBarItem = UITabBarItem(title: "Лента", image: UIImage(systemName: "house"), tag: 0)
            return UINavigationController(rootViewController: feedViewController)
        }
        
        func createLoginViewController() -> UINavigationController {
            let loginFactory = MyLoginFactory().makeLoginInspector()
//            let loginInspector = LoginInspector()
            let loginViewController = LogInViewController()
            loginViewController.loginDelegate = loginFactory 
//            loginViewController.loginDelegate = loginInspector
            loginViewController.title = "Профиль"
            loginViewController.tabBarItem = UITabBarItem(title: "Профиль", image: UIImage(systemName: "person"), tag: 1)
            return UINavigationController(rootViewController: loginViewController)
        }
 
        func createTabBarController() -> UITabBarController {
            let tabBarController = UITabBarController()
            let controllers = [createFeedViewController(), createLoginViewController()]
            tabBarController.viewControllers = controllers

            return tabBarController
        }
        
        window.rootViewController = createTabBarController()
        window.makeKeyAndVisible()
        
        self.window = window
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

