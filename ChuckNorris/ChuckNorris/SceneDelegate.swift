//
//  SceneDelegate.swift
//  ChuckNorris
//
//  Created by Carolina Gomes on 08/02/21.
//  Copyright © 2021 Carolina Gomes. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else {
            return
        }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        let navigation = UINavigationController(rootViewController: HomeViewController())
        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
    }
}
