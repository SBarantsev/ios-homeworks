//
//  SceneDelegate.swift
//  Navigation
//
//  Created by Sergey on 01.04.2023.
//

import UIKit
import FirebaseAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    var mainCoordinator: MainCoordinatorProtocol?
    
    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let scene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: scene)
        let rootViewController = UIViewController()
        let mainCoordinator = MainCoordinator(rootViewController: rootViewController)
        window.rootViewController = mainCoordinator.start()
        window.makeKeyAndVisible()
        
        let appConfiguration = AppConfiguration.allCases.randomElement()!
        print(appConfiguration)
        NetworkService.request(for: appConfiguration)
        
        self.window = window
        self.mainCoordinator = mainCoordinator
        
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        if Auth.auth().currentUser != nil {
            try? Auth.auth().signOut()
        }
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

