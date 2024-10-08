//
//  UserInfoVC.swift
//  GHFollowers
//
//  Created by Mehmet Ali ÇELEBİ on 3.10.2024.
//

import UIKit
import SafariServices

protocol UserInfoViewDelegate: AnyObject {
    func didGetUserInfo(user: User)
    func showAlert(with message: String)
}

protocol ItemInfoViewDelegate: AnyObject {
    func didTapGithubProfile(for user: User)
    func didTapGetFollowers(for user: User)
}

class UserInfoVC: UIViewController {
    var userInfoViewModel: UserInfoViewModelProtocol

    var headerView = UIView()
    var itemViewOne = UIView()
    var itemViewTwo = UIView()
    var joinDateLabel = GFBodyLabel(textAlingment: .center)

    weak var followersUserInfoDelegate: FollowersUserInfoDelegate?
    
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
        configureItems()
        configureJoinDateLabel()
    }
    
    func configureHeaderView() {
        view.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),
        ])
    }
    
    func configureItems() {
        view.addSubview(itemViewOne)
        view.addSubview(itemViewTwo)
        itemViewOne.translatesAutoresizingMaskIntoConstraints = false
        itemViewTwo.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            itemViewOne.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            itemViewOne.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20),
            itemViewOne.heightAnchor.constraint(equalToConstant: 150),
            
            itemViewTwo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            itemViewTwo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: 20),
            itemViewTwo.heightAnchor.constraint(equalToConstant: 150),
        ])
    }
    
    func configureJoinDateLabel() {
        view.addSubview(joinDateLabel)
        joinDateLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            joinDateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            joinDateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            joinDateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: 20),
            joinDateLabel.heightAnchor.constraint(equalToConstant: 50)
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
        let repoVC = GFRepoItemVC(user: user)
        repoVC.delegate = self
        let followersVC = GFFollowersItemVC(user: user)
        followersVC.delegate = self
        
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.add(chilVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
            self.add(chilVC: repoVC, to: self.itemViewOne)
            self.add(chilVC: followersVC, to: self.itemViewTwo)
            
            let date = user.createdAt.convertToDate()
            let displayString = date?.convertToMonthYearFormat()
            self.joinDateLabel.text = "Github Joined: \(displayString ?? "") "
        }
    }
    
    func showAlert(with message: String) {
        presentGFAlert(title: "Error", message: message, buttonTitle: "OK")
    }
}

extension UserInfoVC: ItemInfoViewDelegate {
    func didTapGithubProfile(for user: User) {
        if let url = URL(string: user.htmlUrl) {
            let vc = SFSafariViewController(url: url)
            present(vc, animated: true)
        }
    }
    
    func didTapGetFollowers(for user: User) {
        followersUserInfoDelegate?.didFetchFollowers(for: user.login)
        DispatchQueue.main.async {
            self.dismissVC()
        }
    }
}
