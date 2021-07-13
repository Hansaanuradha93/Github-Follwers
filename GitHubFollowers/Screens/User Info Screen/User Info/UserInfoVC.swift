import UIKit

protocol UserInfoVCDelegate: class {
    func didRequestForFollowers(for username: String)
}


class UserInfoVC: DataLoadingVC {
    
    // MARK: Properties
    private var viewModel: UserInfoVM!
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let headerView = UIView()
    private let itemViewOne = UIView()
    private let itemViewTwo = UIView()
    private let dateLabel = GFBodyLabel(textAlignment: .center)
    private var itemViews = [UIView]()
    weak var delegate: UserInfoVCDelegate!
    
    
    // MARK: Initializers
    init(viewModel: UserInfoVM) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    
    required init?(coder: NSCoder) { fatalError() }
    
    
    // MARK: View Conrtoller
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureScrollView()
        layoutUI()
        getUserInfo()
    }
}


// MARK: - Private Methods
private extension UserInfoVC {
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
    
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationItem.title = viewModel.username
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    
    func getUserInfo() {
        showLoadingView()
        
        viewModel.getUserInfo() { [weak self] user, error in
            guard let self = self else { return }
            self.dismissLoadingView()
            
            if let error = error {
                self.presentGFAlertOnMainTread(title: Strings.badSuffHappened, message: error.rawValue, buttonTitle: Strings.ok)
                return
            }
            
            guard let user = user else { return }
            DispatchQueue.main.async { self.configureUIElements(with: user) }
        }
    }
    
    
    func configureScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.fillSuperview()
        contentView.fill(view: scrollView)
        
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 1000)
        ])
    }
    
    
    func configureUIElements(with user: User) {
        add(childVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
        add(childVC: GFRepoItemVC(user: user, delegate: self), to: self.itemViewOne)
        add(childVC: GFFollowerItemVC(user: user, delegate: self), to: self.itemViewTwo)
        let createdAt = user.createdAt ?? Date()
        dateLabel.text = "\(Strings.githubSince) \(String(describing: createdAt.convertToMonthYearFormat()))"
    }
    
    
    func layoutUI() {
        let padding: CGFloat = 20
        let itemHeight: CGFloat = 140
        itemViews = [headerView, itemViewOne, itemViewTwo, dateLabel]
        
        contentView.addSubviews(headerView, itemViewOne, itemViewTwo, dateLabel)
       
        headerView.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor, padding: .init(top: 0, left: padding, bottom: 0, right: padding), size: .init(width: 0, height: 210))
        itemViewOne.anchor(top: headerView.bottomAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor, padding: .init(top: padding, left: padding, bottom: 0, right: padding), size: .init(width: 0, height: itemHeight))
        itemViewTwo.anchor(top: itemViewOne.bottomAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor, padding: .init(top: padding, left: padding, bottom: 0, right: padding), size: .init(width: 0, height: itemHeight))
        dateLabel.anchor(top: itemViewTwo.bottomAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor, padding: .init(top: padding, left: padding, bottom: 0, right: padding))
    }
    
    
    func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
}


// MARK: - GFRepoItemVCDelegate
extension UserInfoVC: GFRepoItemVCDelegate {
    
    func didTapGitHubProfile(for user: User) {
        guard let url = URL(string: user.htmlUrl ?? "") else {
            presentGFAlertOnMainTread(title: Strings.invalidUrl, message: Strings.theUrlAttachedToThisUserIsInvalid, buttonTitle: Strings.ok)
            return
        }
        presentSafariVC(with: url)
    }
}


// MARK: - GFFollowerItemVCDelegate
extension UserInfoVC: GFFollowerItemVCDelegate {
    
    func didTapGetFollowers(for user: User) {
        guard user.followers != 0 else {
            presentGFAlertOnMainTread(title: Strings.noFollowers, message: Strings.thisUserHasNoFollowers, buttonTitle: Strings.ok)
            return
        }
        delegate.didRequestForFollowers(for: user.login ?? "")
        dismissVC()
    }
}
