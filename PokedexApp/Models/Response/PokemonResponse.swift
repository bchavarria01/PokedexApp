//
//  PokemonResponse.swift
//  PokemonApp
//
//  Created by Byron Chavarría on 2/8/23.
//

import Foundation

struct PokemonResponse: Codable {
    let name: String?
    let url: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case url
    }
}
