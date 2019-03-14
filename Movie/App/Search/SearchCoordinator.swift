//
//  SearchCoordinator.swift
//  Movie
//
//  Created by Alexandre Athayde de Souza Junior on 13/03/19.
//  Copyright © 2019 Alexandre Athayde de Souza Junior. All rights reserved.
//

import Foundation
import UIKit

public protocol SearchCoordinatorDelegate: class {
    func navigateToInfo(id: Int)
}

class SearchCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var rootViewController: UIViewController {
        return navigationController
    }
    
    weak var delegate: SearchCoordinatorDelegate?
    
    private lazy var navigationController: UINavigationController = {
        let navigationController = UINavigationController()
        navigationController.navigationBar.isTranslucent = false
        navigationController.navigationBar.barTintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        navigationController.navigationBar.titleTextAttributes = [.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]
        navigationController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 2)
        return navigationController
    } ()
    
    func start(){
        let viewModel = SearchViewModel(service: Service())
        viewModel.delegateCoord = self
        let searchViewController = SearchViewController.instantiate(viewModel: viewModel)
        navigationController.viewControllers = [searchViewController]
    }
}


extension SearchCoordinator: SearchCoordinatorDelegate {
    
    func navigateToInfo(id: Int) {
        let infoCoord = InfoCoordinator(id: id, navigationController: navigationController)
        infoCoord.start()
    }
}
