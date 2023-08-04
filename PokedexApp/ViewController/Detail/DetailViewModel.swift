//
//  DetailViewModel.swift
//  PokedexApp
//
//  Created by Byron Chavarría on 3/8/23.
//

import RxSwift

final class DetailViewModel {
    // MARK: - Services
    
    let pokemonService: PokemonServices
    let disposeBag = DisposeBag()
    
    // MARK: - LifeCycle
    
    init(pokemonService: PokemonServices) {
        self.pokemonService = pokemonService
    }
    
    func getPokemonDetail(detailUrl: URL) -> Single<PokemonDetailResponse> {
        return pokemonService.getPokemonDetail(with: detailUrl)
            .asObservable()
            .map { $0 }
            .asSingle()
    }
    
    func getPokemonAdditionalInfo(speciesUrL: URL) -> Single<PokemonAdditionalDetailResponse> {
        return pokemonService.getPokemonAdditionalData(with: speciesUrL)
            .asObservable()
            .map { $0 }
            .asSingle()
    }
}
