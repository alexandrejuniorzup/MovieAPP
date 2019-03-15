//
//  InfoCoordinator.swift
//  Movie
//
//  Created by Alexandre Athayde de Souza Junior on 14/03/19.
//  Copyright © 2019 Alexandre Athayde de Souza Junior. All rights reserved.
//

import Foundation
import UIKit

class InfoCoordinator:Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var rootViewController: UIViewController {
        return navigationController
    }
    var infoModule:InfoModule!
    
//    private lazy var navigationController: UINavigationController = {
//        let navigationController = UINavigationController()
//        navigationController.navigationBar.isTranslucent = false
//        return navigationController
//    } ()
    
    func start() {
        navigationController.pushViewController(infoModule.viewController, animated: true)
    }
    
    init(id:Int,fromDatabase: Bool, navigationController: UINavigationController){
        self.navigationController = navigationController
        self.infoModule = buildInfoModule(id: id, fromDatabase: fromDatabase)
    }

    
    
    struct InfoModule {
        let viewController: InfoViewController
        let viewModel: InfoViewModel
    }
    
    private func buildInfoModule(id: Int, fromDatabase: Bool) -> InfoModule {
        let viewModel = InfoViewModel(id: id, service: Service(), database: Database(), fromDatabase: fromDatabase)
        let viewController = InfoViewController.instantiate(viewModel: viewModel)        
        return InfoModule(viewController: viewController, viewModel: viewModel)
    }
    
}
