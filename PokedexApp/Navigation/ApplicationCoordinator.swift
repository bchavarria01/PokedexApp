//
//  ApplicationCoordinator.swift
//  PokedexApp
//
//  Created by Byron Chavarría on 1/8/23.
//

import UIKit

final class ApplicationCoordinator: Coordinator {
            
    // MARK: - Attributes
    
    let window: UIWindow
    var presenter: UINavigationController
    var childCoordinators: [Coordinator] = []
    weak var parentCoordinator: Coordinator?
    
    // MARK: - LifeCycle
    
    init(window: UIWindow) {
        self.window = window
        presenter = UINavigationController()
        window.rootViewController = presenter
    }
    
    // MARK: Start
    
    func start() {
        let welcomeCoordinator = HomeCoordinator(
            presenter: presenter,
            parentCoordinator: self
        )
        welcomeCoordinator.start()
        window.makeKeyAndVisible()
        addChildCoordinator(welcomeCoordinator)
    }
    
}
