//
//  FavoritesListVC.swift
//  GHFollowers
//
//  Created by Mehmet Ali ÇELEBİ on 23.09.2024.
//

import UIKit

protocol FavoritesListDelegate: AnyObject {
    func didChangeFavoriteList()
}

class FavoritesListVC: UIViewController {

    lazy var favoritesViewModel: FavoritesViewModelProtocol = FavoritesViewModel()
    
    let favoritesTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
            view.backgroundColor = .red
        favoritesViewModel.delegate = self
        view.addSubview(favoritesTableView)
        favoritesTableView.delegate = self
        favoritesTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favoritesViewModel.fetchFavorites()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        NSLayoutConstraint.activate([
            favoritesTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            favoritesTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            favoritesTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            favoritesTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}

extension FavoritesListVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favoritesViewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        favoritesViewModel.cellForRowAt(tableView: tableView, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            favoritesViewModel.deleteFavorite(favorite: favoritesViewModel.favorites[indexPath.row])
        default:
            break
        }
    }
}

extension FavoritesListVC: FavoritesListDelegate {
    func didChangeFavoriteList() {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.favoritesTableView.reloadData()
        }
    }
}
