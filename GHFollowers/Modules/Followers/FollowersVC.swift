//
//  FollowersVC.swift
//  GHFollowers
//
//  Created by Mehmet Ali ÇELEBİ on 24.09.2024.
//

import UIKit

class FollowersVC: UIViewController {

    enum Section {
        case main
    }

    var username: String?
    var collectionView: UICollectionView = {
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.identifier)
        return collectionView
    }()
    var collectionViewDiffableDataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        setupUI()
        configureDataSource()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func setupUI() {
        view.addSubview(collectionView)
        collectionView.frame = view.bounds
        collectionView.backgroundColor = .systemBackground
        collectionView.collectionViewLayout = createFlowLayout()
    }
    
    private func createFlowLayout() -> UICollectionViewFlowLayout {
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
    
    func configureDataSource() {
        collectionViewDiffableDataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView) { collectionView, indexPath, follower -> UICollectionViewCell in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.identifier, for: indexPath) as! FollowerCell
            cell.set(follower: follower)
            return cell
        }
    }
    
    
}
