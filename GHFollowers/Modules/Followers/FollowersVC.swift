//
//  FollowersVC.swift
//  GHFollowers
//
//  Created by Mehmet Ali ÇELEBİ on 24.09.2024.
//

import UIKit

enum Section {
    case main
}

protocol FollowersVCDelegate: AnyObject {
    func didUpdateData(with snaphot: NSDiffableDataSourceSnapshot<Section, Follower>)
    func showLoading()
    func hideLoading()
    func showEmptyStateView(message: String)
}

protocol FollowersUserInfoDelegate: AnyObject {
    func didFetchFollowers(for username: String)
}

class FollowersVC: UIViewController {
    let followersViewModel = FollowersViewModel()

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
        followersViewModel.view = self
        setupUI()
        followersViewModel.getFollowers(for: username, page: followersViewModel.page)
        configureDataSource()
        configureSearchController()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationItem.hidesSearchBarWhenScrolling = true
    }
    
    private func setupUI() {
        view.addSubview(collectionView)
        collectionView.frame = view.bounds
        collectionView.backgroundColor = .systemBackground
        collectionView.collectionViewLayout = UIHelper.createFlowLayout(in: view)
        collectionView.delegate = self
    }
    
    func configureDataSource() {
        collectionViewDiffableDataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView) { collectionView, indexPath, follower -> UICollectionViewCell in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.identifier, for: indexPath) as! FollowerCell
            cell.set(follower: follower)
            return cell
        }
    }
    
    func configureSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search for a username"
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
    }
}

extension FollowersVC: FollowersVCDelegate {
    func didUpdateData(with snapshot: NSDiffableDataSourceSnapshot<Section, Follower>) {
        DispatchQueue.main.async {
            self.collectionViewDiffableDataSource.apply(snapshot, animatingDifferences: true , completion: nil)
        }
    }
    
    func showLoading() {
        showLoadingIndicator()
    }
    
    func hideLoading() {
        hideLoadingIndicator()
    }
    
    func showEmptyStateView(message: String) {
        showEmptyStateView(with: message, in: view)
    }
}

extension FollowersVC: UICollectionViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentSize = scrollView.contentSize.height
        let height = scrollView.bounds.height
        
        if offsetY + height >= contentSize {
            guard followersViewModel.hasMoreFollowers else { return }
            followersViewModel.page += 1
            followersViewModel.getFollowers(for: username, page: followersViewModel.page)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray = followersViewModel.isSearching ? followersViewModel.filteredFollowers : followersViewModel.followers
        let follower = activeArray[indexPath.item]
        let userInfoVC = UserInfoVC(userInfoViewModel: UserInfoViewModel(username: follower.login))
        userInfoVC.followersUserInfoDelegate = self
        let nav = UINavigationController(rootViewController: userInfoVC)
        present(nav, animated: true, completion: nil)
    }
}

extension FollowersVC: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else { return }
        followersViewModel.searchFollowers(for: filter, page: 1)
        followersViewModel.isSearching = true
    }
        
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        followersViewModel.updateData(on: followersViewModel.followers)
        followersViewModel.isSearching = false
    }
}

extension FollowersVC: FollowersUserInfoDelegate {
    func didFetchFollowers(for username: String) {
        self.username = username
        self.title = username
        followersViewModel.followers.removeAll()
        followersViewModel.filteredFollowers.removeAll()
        followersViewModel.page = 1
        collectionView.setContentOffset(.zero, animated: true)
        followersViewModel.getFollowers(for: username, page: followersViewModel.page)
        
    }
}
