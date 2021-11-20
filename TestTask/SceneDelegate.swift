//
//  SceneDelegate.swift
//  TestTask
//
//  Created by mage on 19.11.2021.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
	
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)

            let initialVC = JogListViewController()

            window.rootViewController = AppNavigationController(rootViewController: initialVC)
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}

