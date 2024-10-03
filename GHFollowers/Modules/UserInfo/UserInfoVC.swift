//
//  UserInfoVC.swift
//  GHFollowers
//
//  Created by Mehmet Ali ÇELEBİ on 3.10.2024.
//

import UIKit

protocol UserInfoViewDelegate: AnyObject {
    func didGetUserInfo()
    func showAlert(with message: String)
}

class UserInfoVC: UIViewController {
    var userInfoViewModel: UserInfoViewModelProtocol
    
    init(userInfoViewModel: UserInfoViewModelProtocol) {
        self.userInfoViewModel = userInfoViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureNavigationbar()
        userInfoViewModel.view = self
    }
    
    func configureNavigationbar() {
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
}

extension UserInfoVC: UserInfoViewDelegate {
    func didGetUserInfo() {
        
    }
    
    func showAlert(with message: String) {
        presentGFAlert(title: "Error", message: message, buttonTitle: "OK")
    }
}
