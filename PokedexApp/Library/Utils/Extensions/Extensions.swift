//
//  Extensions.swift
//  PokedexApp
//
//  Created by Byron Chavarría on 2/8/23.
//

import UIKit

extension UIView {
    func cornerRadius(with corners: CACornerMask, cornerRadii: CGFloat) {
        self.layer.cornerRadius = cornerRadii
        self.layer.maskedCorners = corners
    }
}

extension String {
    func capitalizingFirstLetter() -> String {
      return prefix(1).uppercased() + self.lowercased().dropFirst()
    }

    mutating func capitalizeFirstLetter() {
      self = self.capitalizingFirstLetter()
    }
    
    func getImageUrl() -> String {
        let newUrl = self.replacingOccurrences(
            of: "https://pokeapi.co/api/v2/pokemon/",
            with: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/"
        )
        return "\(newUrl.dropLast()).png"
        
    }
    
    func getPokemonNumber() -> String {
        let numberFromUrl = self.replacingOccurrences(
            of: "https://pokeapi.co/api/v2/pokemon/",
            with: ""
        )
        
        let number = numberFromUrl.dropLast()
        
        switch number.count {
        case 1:
            return "00\(number)"
        case 2:
            return "0\(number)"
        default:
            return "\(number)"
        }
    }
    
    func getColorByPokemonColor() -> UIColor {
        switch self {
        case "black":
            return R.Colors.pokemonBlack.color
        case "red":
            return R.Colors.pokemonRed.color
        case "blue":
            return R.Colors.pokemonBlue.color
        case "gray":
            return R.Colors.pokemonGray.color
        case "pink":
            return R.Colors.pokemonPink.color
        case "brown":
            return R.Colors.pokemonBrown.color
        case "green":
            return R.Colors.pokemonGreen.color
        case "white":
            return R.Colors.pokemonWhite.color
        case "purple":
            return R.Colors.pokemonPurple.color
        case "yellow":
            return R.Colors.pokemonYellow.color
        default:
            return R.Colors.pokemonRed.color
        }
    }
    
    func getSecondColorByPokemonColor() -> UIColor {
        switch self {
        case "black":
            return R.Colors.black.color
        case "red":
            return R.Colors.red.color
        case "blue":
            return R.Colors.blue.color
        case "gray":
            return R.Colors.gray.color
        case "pink":
            return R.Colors.pink.color
        case "brown":
            return R.Colors.brown.color
        case "green":
            return R.Colors.green.color
        case "white":
            return R.Colors.white.color
        case "purple":
            return R.Colors.purple.color
        case "yellow":
            return R.Colors.yellow.color
        default:
            return R.Colors.red.color
        }
    }
    
    func getPokemonType() -> String {
        switch self {
        case "normal":
            return "✨ Normal"
        case "fire":
            return "🔥 Fuego"
        case "water":
            return "💧 Agua"
        case "grass":
            return "🌱 Planta"
        case "electric":
            return "⚡️ Eléctrico"
        case "ice":
            return "🧊 Hielo"
        case "fighting":
            return "🥊 Pelea"
        case "poison":
            return "☠️ Veneno"
        case "ground":
            return "🌿 Suelo"
        case "flying":
            return "🪽 Volador"
        case "psychic":
            return "🔮 Psíquico"
        case "bug":
            return "🐛 Insecto"
        case "rock":
            return "🪨 Roca"
        case "ghost":
            return "👻 Fantasma"
        case "dark":
            return "⚫️ Oscuridad"
        case "dragon":
            return "🐉 Dragon"
        case "steel":
            return "◻️ Acero"
        case "fairy":
            return "🧚‍♀️ Ada"
        default:
            return ""
        }
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

