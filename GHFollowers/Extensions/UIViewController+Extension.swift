//
//  UIViewController+Extension.swift
//  GHFollowers
//
//  Created by Mehmet Ali ÇELEBİ on 24.09.2024.
//

import UIKit

fileprivate var container: UIView!

extension UIViewController {
    func presentGFAlert(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alert = GFAlertVC(title: title, message: message, buttonTitle: buttonTitle)
            alert.modalPresentationStyle = .overFullScreen
            alert.modalTransitionStyle = .crossDissolve
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func showLoadingIndicator() {
        container = UIView(frame: view.bounds)
        view.addSubview(container)
        container.backgroundColor = .systemBackground
        container.alpha = 0
        
        UIView.animate(withDuration: 0.3) {
            container.alpha = 0.8
        }
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .label
        container.addSubview(activityIndicator)
        activityIndicator.center = container.center
        activityIndicator.startAnimating()
    }
}
