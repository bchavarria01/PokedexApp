//
//  HabitatResponseModel.swift
//  PokemonApp
//
//  Created by Byron Chavarría on 2/8/23.
//

import Foundation

struct HabitatResponseModel: Codable {
    let id: Int?
    let name: String?
    let names: [Name]?
    let pokemonSpecies: [PokemonResponse]?

    enum CodingKeys: String, CodingKey {
        case id, name, names
        case pokemonSpecies = "pokemon_species"
    }
}
