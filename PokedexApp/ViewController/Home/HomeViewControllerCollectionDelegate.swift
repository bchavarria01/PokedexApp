//
//  HomeViewControllerCollectionDelegate.swift
//  PokedexApp
//
//  Created by Byron Chavarría on 2/8/23.
//

import UIKit

final class PokemonDetailViewControllerCollectionDelegate: NSObject {
}

extension PokemonDetailViewControllerCollectionDelegate: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 165, height: 165)
    }
}

