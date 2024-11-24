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
    
    override func viewDidLoad() {
        super.viewDidLoad()
            view.backgroundColor = .red
        favoritesViewModel.delegate = self
    }
}
