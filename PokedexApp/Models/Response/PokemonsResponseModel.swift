//
//  RegionsResponseModel.swift
//  PokemonApp
//
//  Created by Byron Chavarría on 2/8/23.
//

import Foundation

// MARK: - PokemonsResponseModel
struct PokemonsResponseModel: Decodable {
    let count: Int?
    let next: String?
    let previous: String?
    let results: [PokemonResponse]?

    // MARK: - Keys
    
    private enum CodingKeys: String, CodingKey {
        case count = "count"
        case next = "next"
        case previous = "previous"
        case results = "results"
    }
}
