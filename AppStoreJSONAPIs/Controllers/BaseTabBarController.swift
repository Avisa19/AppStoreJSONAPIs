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

        // Do any additional setup after loading the view.
        view.backgroundColor = .systemGreen
        
        let appsController = templateNavController(title: "Apps", tabBarTitle: "Apps", image: #imageLiteral(resourceName: "apps"))
        
        let searchController = templateNavController(title: "Search", tabBarTitle: "Search", image: #imageLiteral(resourceName: "search"))
        
        let todayAppsController = templateNavController(title: "Today icon", tabBarTitle: "Today icon", image: #imageLiteral(resourceName: "icon"))
        
        viewControllers = [
            appsController,
            searchController,
            todayAppsController
        ]
    }
    
    fileprivate func templateNavController(rootController: UIViewController = UINavigationController(rootViewController: UIViewController()), title: String, tabBarTitle: String, image: UIImage) -> UINavigationController {
        let viewController = UIViewController()
        viewController.navigationItem.title = title
             let navController = UINavigationController(rootViewController: viewController)
             navController.tabBarItem.title = tabBarTitle
             navController.navigationBar.prefersLargeTitles = true
        navController.tabBarItem.image = image
        return navController
    }
    


}
