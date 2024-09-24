//
//  UIViewController+Extension.swift
//  GHFollowers
//
//  Created by Mehmet Ali ÇELEBİ on 24.09.2024.
//

import UIKit

extension UIViewController {
    func presentGFAlert(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alert = GFAlertVC(title: title, message: message, buttonTitle: buttonTitle)
            alert.modalPresentationStyle = .overFullScreen
            alert.modalTransitionStyle = .crossDissolve
            self.present(alert, animated: true, completion: nil)
        }
    }
}
