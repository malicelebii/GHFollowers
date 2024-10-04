//
//  GFItemInfoView.swift
//  GHFollowers
//
//  Created by Mehmet Ali ÇELEBİ on 4.10.2024.
//

import UIKit

class GFItemInfoView: UIView {
    let symbolImageView = UIImageView()
    let titleLabel = GFTitleLabel(textAlingment: .left, fontSize: 14)
    let countLabel = GFTitleLabel(textAlingment: .center, fontSize: 14)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
            configure()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        addSubviews()
        setupConstraints()
        
        symbolImageView.contentMode = .scaleAspectFill
        symbolImageView.tintColor = .label
    }
    
    func addSubviews() {
        [symbolImageView, titleLabel, countLabel].forEach { addSubview($0) }
    }
    
    func setupConstraints() {
        [symbolImageView, titleLabel, countLabel].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
            
        NSLayoutConstraint.activate([
            symbolImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            symbolImageView.topAnchor.constraint(equalTo: topAnchor),
            symbolImageView.widthAnchor.constraint(equalToConstant: 20),
            symbolImageView.heightAnchor.constraint(equalToConstant: 20),
            
            titleLabel.centerYAnchor.constraint(equalTo: symbolImageView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: symbolImageView.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 18),
            
            countLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            countLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            countLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            countLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
}
