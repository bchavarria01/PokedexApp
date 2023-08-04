//
//  K.swift
//  PokedexApp
//
//  Created by Byron Chavarría on 3/8/23.
//

import UIKit
import Nuke
import Moya

enum K {
    static let baseURL = "https://pokeapi.co/api/v2/"
    
    enum Components {
        static let navigationBarHeight: CGFloat = 64
    }
    
    enum PokemonServices {
        static let pokemons = URL(string: "\(baseURL)/pokemon/")!
    }
    
    // Nuke
    enum Nuke {
        static let options = ImageLoadingOptions(
            placeholder: R.Base.icPokeball.image,
            transition: .fadeIn(duration: 0.33)
        )
    }
    
    // Moya
    enum MoyaDefaults {
        static let plugins: [PluginType] = [
            NetworkLoggerPlugin(),
            RequestPlugin()
        ]
        static let secureMethods: [Moya.Method] = [.get]
        static let defaultHeaders = [
            "Content-Type": "application/json",
        ]
    }
}
