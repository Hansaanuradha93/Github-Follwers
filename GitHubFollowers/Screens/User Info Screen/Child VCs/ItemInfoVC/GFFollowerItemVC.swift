import UIKit

class GFFollowerItemVC: GFItemInfoVC {
    
    // MARK: - View Conrtoller
    override func viewDidLoad() {
        super.viewDidLoad()
        congifureItems()
    }
}


// MARK: - Private Methods
extension GFFollowerItemVC {
    
    private func congifureItems() {
        itemInfoViewOne.setup(itemInfoType: .followers, withCount: user.followers ?? 0)
        itemInfoViewTwo.setup(itemInfoType: .following, withCount: user.following ?? 0)
        actionButton.setup(backgroundColor: .systemGreen, title: "Get Followers")
    }
}


// MARK: - Override Methods
extension GFFollowerItemVC {
    
    override func actionButtonTapped() {
        delegate.didTapGetFollowers(for: user)
    }
}
