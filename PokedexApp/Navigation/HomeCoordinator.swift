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
        controller.delegate = self
        controller.viewModel = HomeViewModel(pokemonService: PokemonServices())
        presenter.pushViewController(controller, animated: true)
    }
    
    init(presenter: UINavigationController,
         parentCoordinator: Coordinator) {
        self.presenter = presenter
        self.parentCoordinator = parentCoordinator
    }
}

extension HomeCoordinator: HomeViewControllerDelegate {
    func homeViewControllerDidSelectOnePokemon(with pokemonObject: PokemonResponse) {
        let controller = DetailViewController()
        controller.delegate = self
        controller.selectedPokemon = pokemonObject
        controller.viewModel = DetailViewModel(pokemonService: PokemonServices())
        presenter.pushViewController(controller, animated: true)
    }
}

extension HomeCoordinator: DetailViewControllerDelegate {
    func detailViewControllerDelegateDidTapBack() {
        presenter.popViewController(animated: true)
    }
}
