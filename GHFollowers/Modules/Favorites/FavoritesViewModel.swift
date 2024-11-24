protocol FavoritesViewModelProtocol {
    var favorites: [Follower] { get set }
    func fetchFavorites()
    func deleteFavorite(favorite: Follower)
    func numberOfRowsInSection() -> Int
    func cellForRowAt(tableView: UITableView, indexPath: IndexPath) -> FavoriteCell
}
