import UIKit


protocol FollowerListVCDelegate: class {
    func didRequestForFollowers(for username: String)
}

class FollowersListVC: DataLoadingVC {

    // MARK: - Enums
    enum Section {
        case main
    }
    
    
    // MARK: - Properties
    private var username: String!
    private var followers: [Follower]           = []
    private var filteredFollowers: [Follower]   = []
    private var isSearching: Bool               = false
    private var page: Int                       = 1
    private var hasMoreFollowers: Bool          = true
    private var isLoadingFollowers: Bool        = false
    private var lastScrollPosition: CGFloat     = 0
    private var collectionView: UICollectionView!
    private var datasource: UICollectionViewDiffableDataSource<Section, Follower>!
    var addButton: UIBarButtonItem!
    
    
    // MARK: - Initializers
    init(username: String) {
        super.init(nibName: nil, bundle: nil)
        self.username   = username
        title           = username
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - View Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureCollectionView()
        configureSearchViewController()
        getFollowers(username: username, page: page)
        configureDatasoruce()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(false, animated: true) // Show the navigation bar
    }
    
    
    
}


// MARK: - Private methods
extension FollowersListVC {
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createCollectionViewFlowLayout(in: view, for: 3)) // 3 columns
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCollectionViewCell.self, forCellWithReuseIdentifier: FollowerCollectionViewCell.reuseID)
    }
    
    
    private func configureViewController() {
        view.backgroundColor                                    = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles  = true // Get large titles
        addButton                                           = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addFavourite))
        navigationItem.rightBarButtonItem                       = addButton
    }
    
    
    private func configureSearchViewController() {
        let searchViewController                                    = UISearchController()
        searchViewController.searchResultsUpdater                   = self
        searchViewController.searchBar.delegate                     = self
        searchViewController.searchBar.placeholder                  = "Search for a username"
        searchViewController.obscuresBackgroundDuringPresentation   = false
        navigationItem.searchController                             = searchViewController
    }
    
    
    private func getFollowers(username: String, page: Int) {
        self.showLoadingView()
        self.addButton.isEnabled = false
        self.navigationItem.searchController?.searchBar.isHidden = true

        NetworkManager.shared.getFollwers(for: username, page: page) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            DispatchQueue.main.async {
                self.addButton.isEnabled = true
                self.navigationItem.searchController?.searchBar.isHidden = false
            }
            
            switch result {
            case .success(let followers):
                if followers.count < 100 { self.hasMoreFollowers = false } // No more followers
                self.followers.append(contentsOf: followers)
                if self.followers.isEmpty {
                    let message = "This user doesn't have any followers. Go follow them 😀"
                    DispatchQueue.main.async {
                        self.showEmptyStateView(with: message, in: self.view)
                        self.navigationItem.searchController?.searchBar.isHidden = true
                    }
                    return
                }
                self.updateData(on: self.followers)
                
            case .failure(let error):
                self.presentGFAlertOnMainTread(title: "Bad Stuff Happened", message: error.rawValue, buttonTitle: "Ok")
                
            }
            
            self.isLoadingFollowers = true
        }
    }
    
    
    private func configureDatasoruce() {
        datasource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCollectionViewCell.reuseID, for: indexPath) as! FollowerCollectionViewCell
            cell.set(follower: follower)
            return cell
        })
    }
    
    private func updateData(on followers: [Follower]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async { self.datasource.apply(snapshot, animatingDifferences: true) }
    }
    
    
    private func stopSearching() {
        updateData(on: followers)
        filteredFollowers.removeAll()
        isSearching     = false
    }
    
    
    @objc func addFavourite() {
        self.showLoadingView()
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self          = self else { return }
            self.dismissLoadingView()
            switch result {
            case .success(let user):
                let favourite       = Follower(login: user.login, avatarUrl: user.avatarUrl)
                PersistenceManager.updateWith(favourite: favourite, actionType: .add) { [weak self ] error in
                    guard let self  = self else { return }
                    guard let error = error else {
                        self.presentGFAlertOnMainTread(title: "Success!", message: "You have successfully favourited this user 🎉", buttonTitle: "Ok")
                        return
                    }
                    self.presentGFAlertOnMainTread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
                }
                
            case .failure(let error):
                self.presentGFAlertOnMainTread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }

}


// MARK: - CollectionView Delegate
extension FollowersListVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray     = isSearching ? filteredFollowers : followers
        let follower        = activeArray[indexPath.item]
        let destVC          = UserInfoVC(username: follower.login ?? "")
        destVC.delegate     = self
        let navController   = UINavigationController(rootViewController: destVC)
        present(navController, animated: true)
    }
}


// MARK: - ScrollView
extension FollowersListVC {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        lastScrollPosition = scrollView.contentOffset.y
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if lastScrollPosition < scrollView.contentOffset.y {
            navigationItem.hidesSearchBarWhenScrolling = true
        } else if lastScrollPosition > scrollView.contentOffset.y {
            navigationItem.hidesSearchBarWhenScrolling = false
        }
    }
    
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY         = scrollView.contentOffset.y
        let contentHeight   =  scrollView.contentSize.height
        let height          = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {   // Has scrolled to the bottom
            guard hasMoreFollowers, !isLoadingFollowers else { return }
            page += 1
            getFollowers(username: username, page: page)
        }
    }
}


// MARK: - SearchBar
extension FollowersListVC: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        isSearching         = true
        guard let filter    = searchController.searchBar.text, !filter.isEmpty else {
            stopSearching()
            return
        }
        filteredFollowers   = followers.filter { ($0.login?.lowercased().contains(filter.lowercased()) ?? false) }
        updateData(on: filteredFollowers)
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" { stopSearching() }
    }
}



// MARK: - FollowerListVCDeletage
extension FollowersListVC: FollowerListVCDelegate {
    
    func didRequestForFollowers(for username: String) {
        self.username   = username
        title           = username
        page            = 1
        followers.removeAll()
        filteredFollowers.removeAll()
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
        getFollowers(username: username, page: page)
    }
}

