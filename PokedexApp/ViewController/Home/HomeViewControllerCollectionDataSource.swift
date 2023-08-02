//
//  HomeViewControllerCollectionDataSource.swift
//  PokedexApp
//
//  Created by Byron Chavarría on 2/8/23.
//

import UIKit

final class PokemonDetailViewControllerCollectionDataSource: NSObject {
    var items: [PokemonResponse] = []
}

extension PokemonDetailViewControllerCollectionDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: PokemonsCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.cornerRadius(with: [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner], cornerRadii: 10)
//        let urlReplaced = items[indexPath.row].url?.getImageUrl()
//        let url = URL(string: urlReplaced!)
//        cell.pokemonName.text = items[indexPath.row].name?.capitalizingFirstLetter() ?? ""
//        cell.pokemonName.textColor = .black
//        cell.pokemonImage.load(url: url!)
        return cell
    }
}
