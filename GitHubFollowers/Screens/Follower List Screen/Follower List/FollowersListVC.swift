import UIKit

enum Section {
    case main
}


class FollowersListVC: DataLoadingVC {
    
    // MARK: Properties
    private let viewModel = FollowersListVM()
    
    private var collectionView: UICollectionView!
    private var datasource: UICollectionViewDiffableDataSource<Section, Follower>!
    private var addButton: UIBarButtonItem!
    private var username: String!
    
    
    // MARK: Initializers
    init(username: String) {
        super.init(nibName: nil, bundle: nil)
        self.username = username
        title = username
    }
    
    
    required init?(coder: NSCoder) { fatalError() }
    
    
    // MARK: View Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureCollectionView()
        configureSearchViewController()
        getFollowers(username: username, page: viewModel.page)
        configureDatasoruce()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}


// MARK: - Private methods
private extension FollowersListVC {
    
    @objc func addFavourite() {
        showLoadingView()
        
        viewModel.getUserInfo(for: username) { [weak self] user, error in
            guard let self = self else { return }
            self.dismissLoadingView()
            if let error = error {
                self.presentGFAlertOnMainTread(title: Strings.somethingWentWrong, message: error.rawValue, buttonTitle: Strings.ok)
                return
            }
            guard let user = user else { return }
            self.saveFavourite(user: user)
        }
    }
    
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createCollectionViewFlowLayout(in: view, for: 3))
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCollectionViewCell.self, forCellWithReuseIdentifier: FollowerCollectionViewCell.reuseID)
    }
    
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addFavourite))
        navigationItem.rightBarButtonItem = addButton
    }
    
    
    func configureSearchViewController() {
        let searchViewController = UISearchController()
        searchViewController.searchResultsUpdater = self
        searchViewController.searchBar.delegate = self
        searchViewController.searchBar.placeholder = Strings.searchForAUsername
        searchViewController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchViewController
    }
    
    
    func getFollowers(username: String, page: Int) {
        showLoadingView()
        addButton.isEnabled = false
        navigationItem.searchController?.searchBar.isHidden = true
        viewModel.isLoadingFollowers = true

        viewModel.getFollowers(username: username, page: page) { [weak self] followers, error in
            guard let self = self else { return }
            self.dismissLoadingView()
            self.viewModel.isLoadingFollowers = false
            DispatchQueue.main.async {
                self.addButton.isEnabled = true
                self.navigationItem.searchController?.searchBar.isHidden = false
            }
            
            if let error = error {
                self.presentGFAlertOnMainTread(title: Strings.somethingWentWrong, message: error.rawValue, buttonTitle: Strings.ok)
                return
            }
            
            guard let followers = followers else { return }
            self.updateUI(with: followers)
        }
    }
    
    
    func updateUI(with followers: [Follower]) {
        if followers.count < NetworkManager.shared.perPage { self.viewModel.hasMoreFollowers = false }
        viewModel.followers.append(contentsOf: followers)
        if viewModel.followers.isEmpty {
            let message = Strings.userDoesNotHaveFollowers
            DispatchQueue.main.async {
                self.showEmptyStateView(with: message, in: self.view)
                self.navigationItem.searchController?.searchBar.isHidden = true
            }
            return
        }
        updateData(on: viewModel.followers)
    }
    
    
    func configureDatasoruce() {
        datasource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCollectionViewCell.reuseID, for: indexPath) as! FollowerCollectionViewCell
            cell.set(follower: follower)
            return cell
        })
    }
    
    
    func updateData(on followers: [Follower]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async { self.datasource.apply(snapshot, animatingDifferences: true) }
    }
    
    
    func stopSearching() {
        updateData(on: viewModel.followers)
        viewModel.filteredFollowers.removeAll()
        viewModel.isSearching = false
    }
    
    
    func saveFavourite(user: User) {
        let favourite = Follower(login: user.login, avatarUrl: user.avatarUrl)
        
        viewModel.saveFavourite(favourite: favourite) { [weak self] status, message in
            guard let self = self else { return }
            if status {
                self.presentGFAlertOnMainTread(title: Strings.success, message: message, buttonTitle: Strings.ok)
            } else {
                self.presentGFAlertOnMainTread(title: Strings.somethingWentWrong, message: message, buttonTitle: Strings.ok)
            }
        }
    }
}


// MARK: - CollectionView Delegate
extension FollowersListVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray = viewModel.isSearching ? viewModel.filteredFollowers : viewModel.followers
        let follower = activeArray[indexPath.item]
        navigateToUserInfo(username: follower.login ?? "")
    }
}


// MARK: - ScrollView
extension FollowersListVC {
    
    func navigateToUserInfo(username: String) {
        let destVC = UserInfoVC(viewModel: UserInfoVM(username: username))
        destVC.delegate = self
        let navController = UINavigationController(rootViewController: destVC)
        present(navController, animated: true)
    }
    
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        viewModel.lastScrollPosition = scrollView.contentOffset.y
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if viewModel.lastScrollPosition < scrollView.contentOffset.y {
            navigationItem.hidesSearchBarWhenScrolling = true
        } else if viewModel.lastScrollPosition > scrollView.contentOffset.y {
            navigationItem.hidesSearchBarWhenScrolling = false
        }
    }
    
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight =  scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            guard viewModel.hasMoreFollowers, !viewModel.isLoadingFollowers else { return }
            viewModel.page += 1
            getFollowers(username: username, page: viewModel.page)
        }
    }
}


// MARK: - SearchBar
extension FollowersListVC: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        viewModel.isSearching = true
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            stopSearching()
            return
        }
        viewModel.filteredFollowers = viewModel.followers.filter { ($0.login?.lowercased().contains(filter.lowercased()) ?? false) }
        updateData(on: viewModel.filteredFollowers)
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" { stopSearching() }
    }
}



// MARK: - UserInfoVCDelegate
extension FollowersListVC: UserInfoVCDelegate {
    
    func didRequestForFollowers(for username: String) {
        self.username = username
        title = username
        viewModel.page = 1
        viewModel.followers.removeAll()
        viewModel.filteredFollowers.removeAll()
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
        getFollowers(username: username, page: viewModel.page)
    }
}

