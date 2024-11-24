//  FavoritesViewModel.swift
//  GHFollowers
//
//  Created by Mehmet Ali ÇELEBİ on 9.10.2024.
//

import UIKit

protocol FavoritesViewModelProtocol {
    var favorites: [Follower] { get set }
    var delegate: FavoritesListDelegate? { get set }
    func fetchFavorites()
    func deleteFavorite(favorite: Follower)
    func numberOfRowsInSection() -> Int
    func cellForRowAt(tableView: UITableView, indexPath: IndexPath) -> FavoriteCell
}

final class FavoritesViewModel: FavoritesViewModelProtocol {
    var favorites: [Follower] = []
    weak var delegate: FavoritesListDelegate?

extension FavoritesViewModel {
    func numberOfRowsInSection() -> Int {
        favorites.count
    }
    
    func cellForRowAt(tableView: UITableView, indexPath: IndexPath) -> FavoriteCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.identifier) as! FavoriteCell
        cell.configure(favorites[indexPath.row])
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}
