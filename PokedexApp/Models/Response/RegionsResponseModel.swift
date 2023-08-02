//
//  RegionsResponseModel.swift
//  PokemonApp
//
//  Created by Byron Chavarría on 2/8/23.
//

import Foundation

// MARK: - RegionsResponse
struct RegionsResponseModel: Decodable {
    let count: Int?
    let next: String?
    let previous: String?
    let regions: [PokemonResponse]?

    // MARK: - Keys
    
    private enum CodingKeys: String, CodingKey {
        case count = "count"
        case next = "next"
        case previous = "previous"
        case regions = "results"
    }
}
