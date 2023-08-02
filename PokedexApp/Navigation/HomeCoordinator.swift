//
//  HomeCoordinator.swift
//  PokedexApp
//
//  Created by Byron Chavarría on 1/8/23.
//

import UIKit
import Presentr

final class HomeCoordinator: Coordinator {
    var presenter: UINavigationController
    
    var parentCoordinator: Coordinator?
    
    var childCoordinators: [Coordinator] = []
    
    func start() {
        let controller = HomeViewController()
//        controller.delegate = self
        presenter.pushViewController(controller, animated: true)
    }
    
    init(presenter: UINavigationController,
         parentCoordinator: Coordinator) {
        self.presenter = presenter
        self.parentCoordinator = parentCoordinator
    }
}

