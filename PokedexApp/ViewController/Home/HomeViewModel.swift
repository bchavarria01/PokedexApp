//
//  HomeViewModel.swift
//  PokedexApp
//
//  Created by Byron Chavarría on 3/8/23.
//

import RxSwift

final class HomeViewModel {
    // MARK: - Services
    
    let pokemonService: PokemonServices
    let disposeBag = DisposeBag()
    
    // MARK: - LifeCycle
    
    init(pokemonService: PokemonServices) {
        self.pokemonService = pokemonService
    }
    
    func getPokemons(limit: String) -> Single<PokemonsResponseModel> {
        return pokemonService.getPokemons(with: limit)
            .asObservable()
            .map { $0 }
            .asSingle()
    }
}
