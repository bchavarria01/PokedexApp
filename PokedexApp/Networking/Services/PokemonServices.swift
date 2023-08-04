//
//  PokemonServices.swift
//  PokedexApp
//
//  Created by Byron Chavarría on 3/8/23.
//

import Moya
import RxSwift

final class PokemonServices {
    
    // MARK: - ProvidMoers
    
    private let provider = MoyaProvider<PokemonsProvider>(
        plugins: K.MoyaDefaults.plugins
    )
    
    // MARK: - Regions
    
    func getPokemons(with limit: String?) -> Single<PokemonsResponseModel> {
        return provider.rx
            .request(.getPokemons(limit: limit))
            .filterSuccessfulStatusCodes()
            .map(PokemonsResponseModel.self)
            .asObservable()
            .asSingle()
    }
    
    func getPokemonDetail(with pokemonDetailUrl: URL) -> Single<PokemonDetailResponse> {
        return provider.rx
            .request(.getPokemonDetail(detailUrl: pokemonDetailUrl))
            .filterSuccessfulStatusCodes()
            .map(PokemonDetailResponse.self)
            .asObservable()
            .asSingle()
        
    }
    
    func getPokemonAdditionalData(with pokemonSpeciesUrl: URL) -> Single<PokemonAdditionalDetailResponse> {
        return provider.rx
            .request(.getPokemonDetail(detailUrl: pokemonSpeciesUrl))
            .filterSuccessfulStatusCodes()
            .map(PokemonAdditionalDetailResponse.self)
            .asObservable()
            .asSingle()
    }
    
    func getNextPokemon(with url: URL) -> Single<PokemonsResponseModel> {
        return provider.rx
            .request(.getNextPokemons(url: url))
            .filterSuccessfulStatusCodes()
            .map(PokemonsResponseModel.self)
            .asObservable()
            .asSingle()
    }
    
}
