//
//  FavoriteCell.swift
//  GHFollowers
//
//  Created by Mehmet Ali ÇELEBİ on 8.11.2024.
//

import UIKit

class FavoriteCell: UITableViewCell {
    static let identifier: String = "FavoriteCell"
    
    let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .label
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier:  reuseIdentifier)
        addSubview(avatarImageView)
        addSubview(usernameLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        NSLayoutConstraint.activate([
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            avatarImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            avatarImageView.heightAnchor.constraint(equalToConstant: 50),
            avatarImageView.widthAnchor.constraint(equalToConstant: 50),
            
            usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 20),
            usernameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor)
        ])
    }
    
    func configure(_ favorite: Follower) {
        if let url = URL(string: favorite.avatarUrl) {
            URLSession.shared.dataTask(with: url) { data, _, _ in
                if let data {
                    DispatchQueue.main.async {
                        self.avatarImageView.image = UIImage(data: data)
                    }
                }
            }.resume()
        }
        
        usernameLabel.text = favorite.login
    }
}
