
//
//  HomeCoordinator.swift
//  Movie
//
//  Created by Alexandre Athayde de Souza Junior on 13/03/19.
//  Copyright © 2019 Alexandre Athayde de Souza Junior. All rights reserved.
//

import Foundation
import UIKit

public protocol HomeCoordinatorDelegate:class {
    func navigateToInfo(id:Int)
}

class HomeCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var rootViewController: UIViewController {
        return navigationController
    }
    
    weak var delegate: HomeCoordinatorDelegate?
    
    
    private lazy var navigationController: UINavigationController = {
        let navigationController = UINavigationController()
        navigationController.navigationBar.isTranslucent = false
        navigationController.navigationBar.barTintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        navigationController.navigationBar.titleTextAttributes = [.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]
        navigationController.tabBarItem = UITabBarItem(tabBarSystemItem: .topRated, tag: 1)
        return navigationController
    } ()
    
    func start(){
        let viewModel = HomeViewModel(service: Service())
        viewModel.delegateCoord = self
        let home = HomeViewController.instantiate(viewModel: viewModel)
        navigationController.viewControllers = [home]
    }
    
}

extension HomeCoordinator: HomeCoordinatorDelegate {
    
    func navigateToInfo(id: Int) {
        let infoCoord = InfoCoordinator(id: id,navigationController: navigationController)
        infoCoord.start()
    }
}
