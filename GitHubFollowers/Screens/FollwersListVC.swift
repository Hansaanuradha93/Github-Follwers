//
//  FollwersListViewController.swift
//  GitHubFollowers
//
//  Created by Hansa Anuradha on 1/1/20.
//  Copyright © 2020 Hansa Anuradha. All rights reserved.
//

import UIKit

class FollwersListVC: UIViewController {

    enum Section {
        case main
    }
    
    var username: String!
    var followers: [Follower] = []
    
    var collectionView: UICollectionView!
    var datasource: UICollectionViewDiffableDataSource<Section, Follower>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureCollectionView()
        getFollowers()
        configureDatasoruce()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(false, animated: true) // Show the navigation bar
    }
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCollectionViewFlowLayout(for: 3)) // 3 columns
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCollectionViewCell.self, forCellWithReuseIdentifier: FollowerCollectionViewCell.reuseID)
    }
    
    private func createCollectionViewFlowLayout(for columns: CGFloat) -> UICollectionViewFlowLayout {
        
        let collectionViewWidth                 = view.bounds.width
        let padding: CGFloat                    = 12
        let minimumInterItemSpacing: CGFloat    = 10
        let spaceBetweenCells                   = minimumInterItemSpacing * (columns - 1)
        let adjustedWidth                       = collectionViewWidth - spaceBetweenCells - padding * 2
        let width: CGFloat                      = floor(adjustedWidth / columns)
        let height: CGFloat                     = width + 40
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset                 = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize                     = CGSize(width: width, height: height)
        
        return flowLayout
    }
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true // Get large titles
    }
    
    private func getFollowers() {
        NetworkManager.shared.getFollwers(for: username, page: 1) { result in
            
            switch result {
            case .success(let followers):
                self.followers = followers
                self.updateData()
                
            case .failure(let error):
                self.presentGFAlertOnMainTread(title: "Bad Stuff Happened", message: error.rawValue, buttonTitle: "Ok")
                
            }
        }
    }
    
    private func configureDatasoruce() {
        datasource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCollectionViewCell.reuseID, for: indexPath) as! FollowerCollectionViewCell
            cell.set(follower: follower)
            return cell
        })
    }
    
    private func updateData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async { self.datasource.apply(snapshot, animatingDifferences: true) }
    }

}
