import UIKit

protocol GFFollowerItemVCDelegate: class {
    func didTapGetFollowers(for user: User)
}


class GFFollowerItemVC: GFItemInfoVC {
    
    // MARK: Properties
    weak var delegate: GFFollowerItemVCDelegate!
    
    
    // MARK: Initializers
    init(user: User, delegate: GFFollowerItemVCDelegate) {
        super.init(user: user)
        self.delegate = delegate
    }
    
    
    required init?(coder: NSCoder) { fatalError() }
    
    
    // MARK: View Conrtoller
    override func viewDidLoad() {
        super.viewDidLoad()
        congifureItems()
    }
}


// MARK: - Private Methods
private extension GFFollowerItemVC {
    
    func congifureItems() {
        itemInfoViewOne.setup(itemInfoType: .followers, withCount: user.followers ?? 0)
        itemInfoViewTwo.setup(itemInfoType: .following, withCount: user.following ?? 0)
        actionButton.setup(backgroundColor: .systemGreen, title: Strings.getFollowers)
    }
}


// MARK: - Override Methods
extension GFFollowerItemVC {
    
    override func actionButtonTapped() {
        delegate.didTapGetFollowers(for: user)
    }
}
