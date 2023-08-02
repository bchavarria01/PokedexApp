//
//  HomeViewControllerCollectionDelegate.swift
//  PokedexApp
//
//  Created by Byron Chavarría on 2/8/23.
//

import UIKit

final class PokemonDetailViewControllerCollectionDelegate: NSObject {
    var items: [PokemonResponse] = []
//    weak var delegate: PokemonDetailViewControllerDelegate?
}

extension PokemonDetailViewControllerCollectionDelegate: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let url = items[indexPath.row].url ?? ""
        _ = url
//        delegate?.PokemonDetailViewControllerDidSelectPokemon()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 165, height: 165)
    }
}

