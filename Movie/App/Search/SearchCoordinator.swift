//
//  SearchCoordinator.swift
//  Movie
//
//  Created by Alexandre Athayde de Souza Junior on 13/03/19.
//  Copyright © 2019 Alexandre Athayde de Souza Junior. All rights reserved.
//

import Foundation
import UIKit

class SearchCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var rootViewController: UIViewController {
        return navigationController
    }
    
    private lazy var navigationController: UINavigationController = {
        let navigationController = UINavigationController()
        navigationController.navigationBar.isTranslucent = false
        navigationController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 2)
        return navigationController
    } ()
    
    func start(){
        let searchViewController = SearchViewController.instantiate()
        navigationController.viewControllers = [searchViewController]
    }
}
