//
//  UserInfoVC.swift
//  GHFollowers
//
//  Created by Mehmet Ali ÇELEBİ on 3.10.2024.
//

import UIKit

class UserInfoVC: UIViewController {
    var username: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureNavigationbar()
    }
    
    func configureNavigationbar() {
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
}
