//
//  GFFollowersItemVC.swift
//  GHFollowers
//
//  Created by Mehmet Ali ÇELEBİ on 7.10.2024.
//

import UIKit

class GFFollowersItemVC: GFItemInfoVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    private func configureItems() {
        itemInfoViewOne.set(itemInfoType: .followers, withCount: user.followers)
        itemInfoViewTwo.set(itemInfoType: .following, withCount: user.following)
        actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
    }
}
