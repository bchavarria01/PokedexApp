//
//  HomeViewModel.swift
//  PokedexApp
//
//  Created by Byron Chavarría on 3/8/23.
//

import RxSwift
import RxCocoa

final class HomeViewModel {
    // MARK: - Services
    
    let pokemonService: PokemonServices
    let disposeBag = DisposeBag()
    
    let items = BehaviorRelay<[PokemonResponse]?>(value: nil)
    
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
    
    func getNextPokemons(nextPokemonUrl: String) -> Single<PokemonsResponseModel> {
        let url = URL(string: nextPokemonUrl)!
        return pokemonService.getNextPokemon(with: url)
            .asObservable()
            .map { $0 }
            .asSingle()
    }
    
    
}
