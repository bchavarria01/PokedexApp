//
//  HomeViewControllerDelegate.swift
//  PokedexApp
//
//  Created by Byron Chavarría on 2/8/23.
//

import Foundation

protocol HomeViewControllerDelegate: AnyObject {
    func homeViewControllerDidSelectOnePokemon(with pokemonObject: PokemonResponse)
}
