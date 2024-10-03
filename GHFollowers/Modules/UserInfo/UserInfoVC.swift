//
//  UserInfoVC.swift
//  GHFollowers
//
//  Created by Mehmet Ali ÇELEBİ on 3.10.2024.
//

import UIKit

protocol UserInfoViewDelegate: AnyObject {
    func didGetUserInfo(user: User)
    func showAlert(with message: String)
}

class UserInfoVC: UIViewController {
    var userInfoViewModel: UserInfoViewModelProtocol

    var headerView = UIView()
    
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
        configureHeaderView()
    }
    
    func configureHeaderView() {
        view.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180)
        ])
    }
    
    func add(chilVC: UIViewController, to containerView: UIView) {
        addChild(chilVC)
        containerView.addSubview(chilVC.view)
        chilVC.view.frame = containerView.bounds
        chilVC.didMove(toParent: self)
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
    func didGetUserInfo(user: User) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.add(chilVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
        }
    }
    
    func showAlert(with message: String) {
        presentGFAlert(title: "Error", message: message, buttonTitle: "OK")
    }
}
