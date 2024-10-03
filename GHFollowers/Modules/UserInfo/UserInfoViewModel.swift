//
//  UserInfoViewModel.swift
//  GHFollowers
//
//  Created by Mehmet Ali ÇELEBİ on 3.10.2024.
//

protocol UserInfoViewModelProtocol {
    var view: UserInfoViewDelegate? { get set}
    func getUserInfo()
}

final class UserInfoViewModel: UserInfoViewModelProtocol {
    let networkManager: NetworkManagerProtocol
    let username: String
    weak var view: UserInfoViewDelegate?
    
    init(networkManager: NetworkManagerProtocol = NetworkManager.shared, username: String) {
        self.networkManager = networkManager
        self.username = username
        getUserInfo()
    }
    
    func getUserInfo() {
        networkManager.getUser(for: username) {[weak self] result in
            guard let self else { return }
            switch result {
            case .success(let user):
                print(user)
                view?.didGetUserInfo(user: user)
            case .failure(let error):
                self.view?.showAlert(with: error.rawValue)
            }
        }
    }
}
