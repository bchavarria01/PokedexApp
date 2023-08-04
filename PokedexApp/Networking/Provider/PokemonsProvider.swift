//
//  PokemonsProvider.swift
//  PokedexApp
//
//  Created by Byron Chavarría on 3/8/23.
//

import Moya

enum PokemonsProvider {
    case getPokemons(limit: String?)
    case getPokemonDetail(detailUrl: URL)
    case getPokemonAdditionalDetail(detailUrl: URL)
    case getNextPokemons(url: URL)
}

extension PokemonsProvider: TargetType {
    var path: String {
        return ""
    }
    
    var baseURL: URL {
        switch self {
        case let .getPokemons(limit):
            let url = URL(string: "\(K.PokemonServices.pokemons.absoluteString)?limit=\(limit ?? "10")")
            return url!
            
        case let .getPokemonDetail(detailUrl), let .getPokemonAdditionalDetail(detailUrl):
            return detailUrl
            
        case let .getNextPokemons(url):
            return url
        }
    }
    
    var method: Method {
        switch self {
        default:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        return .requestParameters(parameters: [:], encoding: URLEncoding.default)
    }
    
    var headers: [String : String]? {
        return K.MoyaDefaults.defaultHeaders
    }
}

