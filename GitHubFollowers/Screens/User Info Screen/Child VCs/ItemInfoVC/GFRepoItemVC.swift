import UIKit

protocol GFRepoItemVCDelegate: class {
    func didTapGitHubProfile(for user: User)
}


class GFRepoItemVC: GFItemInfoVC {
    
    // MARK: - Properties
    weak var delegate: GFRepoItemVCDelegate!
    
    
    // MARK: - Initializers
    init(user: User, delegate: GFRepoItemVCDelegate) {
        super.init(user: user)
        self.delegate = delegate
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - View Conrtoller
    override func viewDidLoad() {
        super.viewDidLoad()
        congifureItems()
    }
}


// MARK: - Private Methods
extension GFRepoItemVC {
    
   private func congifureItems() {
        itemInfoViewOne.setup(itemInfoType: .repos, withCount: user.publicRepos ?? 0)
        itemInfoViewTwo.setup(itemInfoType: .gists, withCount: user.publicGists ?? 0)
        actionButton.setup(backgroundColor: .systemPurple, title: "Github Profile")
    }
}


// MARK: - Override Methods
extension GFRepoItemVC {
    
    override func actionButtonTapped() {
        delegate.didTapGitHubProfile(for: user)
    }
}
