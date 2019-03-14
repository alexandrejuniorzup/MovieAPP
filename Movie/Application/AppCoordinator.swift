//
//  AppCoordinator.swift
//  Movie
//
//  Created by Alexandre Athayde de Souza Junior on 13/03/19.
//  Copyright © 2019 Alexandre Athayde de Souza Junior. All rights reserved.
//

import Foundation
import UIKit

class AppCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var rootViewController: UIViewController {
        return tabBarController
    }
    private lazy var tabBarController: UITabBarController = {
        let tabBarController = UITabBarController()
        tabBarController.tabBar.isTranslucent = false
        tabBarController.tabBar.barTintColor = #colorLiteral(red: 1, green: 0.2060600442, blue: 0.1049270352, alpha: 1)
        return tabBarController
    } ()
    
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
        
        window.rootViewController = self.rootViewController
        window.makeKeyAndVisible()
    }
    
    private func showTabBarViewController() {
        tabBarController.viewControllers = getTabControllerList()
    }
    
    func start() {
        showTabBarViewController()
    }
    
    private func getTabControllerList() -> [UIViewController] {
        
        var list = [UIViewController]()
        
        let homeCoordinator = HomeCoordinator()
        homeCoordinator.start()
        addChildCoordinator(homeCoordinator)
        
    
        let searchCoordinator = SearchCoordinator()
        searchCoordinator.start()
        addChildCoordinator(searchCoordinator)
        
        let favoriteCoordinator = FavoriteCoordinator()
        favoriteCoordinator.start()
        addChildCoordinator(favoriteCoordinator)

        list.append(homeCoordinator.rootViewController)
        list.append(searchCoordinator.rootViewController)
        list.append(favoriteCoordinator.rootViewController)
        return list
    }
    
}
