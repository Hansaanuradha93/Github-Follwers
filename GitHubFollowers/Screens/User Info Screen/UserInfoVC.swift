import UIKit

protocol UserInfoVCDelegate: class {
    func didRequestForFollowers(for username: String)
}


class UserInfoVC: DataLoadingVC {
    
    // MARK: - Properties
    private let scrollView      = UIScrollView()
    private let contentView     = UIView()
    
    private let headerView      = UIView()
    private let itemViewOne     = UIView()
    private let itemViewTwo     = UIView()
    private let dateLabel       = GFBodyLabel(textAlignment: .center)
    private var itemViews       = [UIView]()
    private var username: String!
    weak var delegate   : UserInfoVCDelegate!
    
    
    // MARK: - Initializers
    init(username: String) {
        super.init(nibName: nil, bundle: nil)
        self.username = username
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - View Conrtoller
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        layoutUI()
        getUserInfo(username: username)
    }
}


// MARK: - Private Methods
extension UserInfoVC {
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationItem.title                = username
        let doneButton                      = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem   = doneButton
    }
    
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
    
    
    private func getUserInfo(username: String) {
        self.showLoadingView()
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
        guard let self = self else { return }
            self.dismissLoadingView()
            
            switch result {
            case .success(let user):
                DispatchQueue.main.async { self.configureUIElements(with: user) }
            
            case .failure(let error):
                print(error)
                self.presentGFAlertOnMainTread(title: "Bad Stuff Happened", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }
    
    
    private func configureScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints    = false
        contentView.translatesAutoresizingMaskIntoConstraints   = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 1),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 1)
        ])
    }
    
    
    private func configureUIElements(with user: User) {
        self.add(childVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
        self.add(childVC: GFRepoItemVC(user: user, delegate: self), to: self.itemViewOne)
        self.add(childVC: GFFollowerItemVC(user: user, delegate: self), to: self.itemViewTwo)
        let createdAt           = user.createdAt ?? Date()
        self.dateLabel.text     = "GitHub since \(String(describing: createdAt.convertToMonthYearFormat()))"
    }
    
    
    private func layoutUI() {
        let padding: CGFloat    = 20
        let itemHeight: CGFloat = 140
        itemViews               = [headerView, itemViewOne, itemViewTwo, dateLabel]
        
        for itemView in itemViews {
            view.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                itemView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
            ])
        }
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 210),
            
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),
            
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight),
            
            dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    private func add(childVC: UIViewController, to containerView: UIView) {
        self.addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }

}


// MARK: - GFRepoItemVCDelegate
extension UserInfoVC: GFRepoItemVCDelegate {
    
    func didTapGitHubProfile(for user: User) {
        guard let url = URL(string: user.htmlUrl ?? "") else {
            presentGFAlertOnMainTread(title: "Invalid URL", message: "The url attached to this user is invalid.", buttonTitle: "Ok")
            return
        }
        presentSafariVC(with: url)
    }
    
    
}


// MARK: - GFFollowerItemVCDelegate
extension UserInfoVC: GFFollowerItemVCDelegate {
    
    func didTapGetFollowers(for user: User) {
        guard user.followers != 0 else {
            presentGFAlertOnMainTread(title: "No Followers", message: "This user doesn't have any followers. Go follow this user 😀.", buttonTitle: "Ok")
            return
        }
        delegate.didRequestForFollowers(for: user.login ?? "")
        dismissVC()
    }
    
    
}
