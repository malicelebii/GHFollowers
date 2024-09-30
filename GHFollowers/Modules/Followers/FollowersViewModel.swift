//
//  FollowersViewModel.swift
//  GHFollowers
//
//  Created by Mehmet Ali ÇELEBİ on 26.09.2024.
//

import UIKit

protocol FollowersViewModelProtocol {
    func updateData()
    func getFollowers(for username: String?, page: Int)
}

final class FollowersViewModel: FollowersViewModelProtocol {
    var followers: [Follower] = []
    var page: Int = 1
    let networkManager: NetworkManagerProtocol
    weak var view: FollowersVCDelegate?
    
    init(networkManager: NetworkManagerProtocol = NetworkManager.shared) {
        self.networkManager = networkManager
    }
    
    func updateData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        view?.didUpdateData(with: snapshot)
    }
    
    func getFollowers(for username: String?, page: Int) {
        guard let username else { return }
        networkManager.getFollowers(for: username, page: page) {[weak self] result in
            switch result {
            case .success(let followers):
                self?.followers = followers
                self?.updateData()
            case .failure(let error):
                print(error)
            }
        }
    }
}
