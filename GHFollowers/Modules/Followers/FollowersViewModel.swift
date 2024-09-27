//
//  FollowersViewModel.swift
//  GHFollowers
//
//  Created by Mehmet Ali ÇELEBİ on 26.09.2024.
//

import UIKit

protocol FollowersViewModelProtocol {
    func updateData()
    func getFollowers(for username: String?)
}

final class FollowersViewModel: FollowersViewModelProtocol {
    var followers: [Follower] = []
    let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol = NetworkManager.shared) {
        self.networkManager = networkManager
    }
    
    func updateData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
//        DispatchQueue.main.async {
//            self.collectionViewDiffableDataSource.apply(snapshot, animatingDifferences: true , completion: nil)
//        }
    }
    
    func getFollowers(for username: String?) {
        guard let username else { return }
        networkManager.getFollowers(for: username, page: 1) {[weak self] result in
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
