//
//  GFRepoItemVC.swift
//  GHFollowers
//
//  Created by Mehmet Ali ÇELEBİ on 7.10.2024.
//

import UIKit

class GFRepoItemVC: GFItemInfoVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
        configureActionButton()
    }
    
    private func configureItems() {
        itemInfoViewOne.set(itemInfoType: .repos, withCount: user.publicRepos)
        itemInfoViewTwo.set(itemInfoType: .gists, withCount: user.publicGists)
        actionButton.set(backgroundColor: .systemPurple, title: "Github Profile")
    }
    
    func configureActionButton() {
        actionButton.addTarget(self, action: #selector(didTapActionButton), for: .touchUpInside)
    }
    
    @objc func didTapActionButton() {
        delegate?.didTapGithubProfile(for: user)
    }
}
