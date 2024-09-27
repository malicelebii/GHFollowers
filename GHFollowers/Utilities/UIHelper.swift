//
//  UIHelper.swift
//  GHFollowers
//
//  Created by Mehmet Ali ÇELEBİ on 27.09.2024.
//

import UIKit

struct UIHelper {
    
    static func createFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let width = view.bounds.width
        let padding: CGFloat = 12
        let minimumInteritemSpacing: CGFloat = 10
        let availableWidth = width - (padding * 2) - (minimumInteritemSpacing * 2)
        let itemWidth = availableWidth / 3
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)
        layout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        return layout
    }
}
