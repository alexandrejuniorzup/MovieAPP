//
//  FavoriteCoordinator.swift
//  Movie
//
//  Created by Alexandre Athayde de Souza Junior on 13/03/19.
//  Copyright © 2019 Alexandre Athayde de Souza Junior. All rights reserved.
//

import Foundation
import UIKit

public protocol FavoriteCoordinatorDelegate:class {
    func navigateToInfo(id: Int)
}

class FavoriteCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var rootViewController: UIViewController {
        return navigationController
    }
    
    weak var delegate: FavoriteCoordinatorDelegate?
    
    private lazy var navigationController: UINavigationController = {
        let navigationController = UINavigationController()
        navigationController.navigationBar.isTranslucent = false
        navigationController.navigationBar.barTintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        navigationController.navigationBar.titleTextAttributes = [.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]
        navigationController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        return navigationController
    } ()
    
    func start(){
        let viewModel = FavoriteViewModel(database: Database())
        viewModel.delegateCoord = self
        let favoriteViewController = FavoriteViewController.instantiate(viewModel: viewModel)
        navigationController.viewControllers = [favoriteViewController]
    }
}

extension FavoriteCoordinator: FavoriteCoordinatorDelegate {
    
    func navigateToInfo(id: Int) {
        let infoCoord = InfoCoordinator(id: id, navigationController: navigationController)
        infoCoord.start()
    }
}
