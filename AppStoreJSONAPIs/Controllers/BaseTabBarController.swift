//
//  BaseTabBarController.swift
//  AppStoreJSONAPIs
//
//  Created by Avisa Poshtkouhi on 14/11/19.
//  Copyright © 2019 Avisa Poshtkouhi. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        viewControllers = [
            
            createNavController(viewController: UIViewController(), title: "Today", imageName: #imageLiteral(resourceName: "icon")),
            
            createNavController(viewController: AppsController(), title: "Apps", imageName: #imageLiteral(resourceName: "apps")),
            
            createNavController(viewController: AppsSearchController(), title: "Search", imageName: #imageLiteral(resourceName: "search"))
        ]
    }
    

     
    fileprivate func createNavController(viewController: UIViewController, title: String, imageName: UIImage) -> UIViewController {
        
        let navController = UINavigationController(rootViewController: viewController)
        viewController.view.backgroundColor = .white
        viewController.navigationItem.title = title
        navController.navigationBar.prefersLargeTitles = true
        navController.tabBarItem.title = title
        navController.tabBarItem.image = imageName
        return navController
    }
    

}
