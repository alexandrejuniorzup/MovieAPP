
//
//  HomeCoordinator.swift
//  Movie
//
//  Created by Alexandre Athayde de Souza Junior on 13/03/19.
//  Copyright © 2019 Alexandre Athayde de Souza Junior. All rights reserved.
//

import Foundation
import UIKit

class HomeCoordinator: Coordinator {
 
    var childCoordinators: [Coordinator] = []
    var rootViewController: UIViewController {
        return navigationController
    }
    
    private lazy var navigationController: UINavigationController = {
        let navigationController = UINavigationController()
        navigationController.navigationBar.isTranslucent = false
        navigationController.tabBarItem = UITabBarItem(tabBarSystemItem: .topRated, tag: 1)
        return navigationController
    } ()
    
    func start(){
        let home = HomeViewController.instantiate()
        navigationController.viewControllers = [home]
    }
    
    
}
