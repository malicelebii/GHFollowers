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
    var hasMoreFollowers: Bool = true
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
        view?.showLoading()
        networkManager.getFollowers(for: username, page: page) {[weak self] result in
            guard let self else { return }
            switch result {
            case .success(let followers):
                if followers.count < 100 {
                    self.hasMoreFollowers = false
                }
                self.followers.append(contentsOf: followers)
                if self.followers.isEmpty {
                    let message = "No followers found for \(username)"
                    DispatchQueue.main.async {
                        self.view?.showEmptyStateView(message: message)
                    }
                    return
                }
                self.updateData()
            case .failure(let error):
                print(error)
            }
            self.view?.hideLoading()
        }
    }
}
