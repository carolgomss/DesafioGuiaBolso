//
//  GuiaBolsoViewController.swift
//  ChuckNorris
//
//  Created by Carolina Gomes on 09/02/21.
//  Copyright © 2021 Carolina Gomes. All rights reserved.
//

import UIKit

class GBViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .gbYellow
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            
            navigationItem.standardAppearance = appearance
            navigationItem.scrollEdgeAppearance = appearance
            navigationItem.compactAppearance = appearance
            
            let buttonAppearance = UIBarButtonItemAppearance()
            buttonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.white]
            navigationItem.standardAppearance?.buttonAppearance = buttonAppearance
            navigationItem.compactAppearance?.buttonAppearance = buttonAppearance
        } else {
            navigationController?.navigationBar.barTintColor = .gbYellow
            navigationController?.navigationBar.isTranslucent = true
            navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        }
        navigationController?.navigationBar.tintColor = .white
    }
}
