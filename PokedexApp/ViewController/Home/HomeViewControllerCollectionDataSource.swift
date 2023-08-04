//
//  HomeViewControllerCollectionDataSource.swift
//  PokedexApp
//
//  Created by Byron Chavarría on 2/8/23.
//

import UIKit
import Nuke

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
        let item = items[indexPath.row]
        let urlReplaced = item.url?.getImageUrl()
        let url = URL(string: urlReplaced!)
        cell.pokemonName.text = items[indexPath.row].name?.capitalizingFirstLetter() ?? ""
        Nuke.loadImage(with: url, options: K.Nuke.options, into: cell.pokemonImage)
        cell.pokemonNumber.text = "#\(item.url?.getPokemonNumber() ?? "")"
        return cell
    }
}
