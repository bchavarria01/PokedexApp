//
//  PokemonsCollectionViewCell.swift
//  PokedexApp
//
//  Created by Byron Chavarría on 2/8/23.
//

import UIKit
import Reusable

class PokemonsCollectionViewCell: UICollectionViewCell, NibReusable {

    // MARK: - IBOutlets
    
    @IBOutlet weak var pokemonNumber: UILabel!
    @IBOutlet weak var pokemonName: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    
    // MARK: - LifeCycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
