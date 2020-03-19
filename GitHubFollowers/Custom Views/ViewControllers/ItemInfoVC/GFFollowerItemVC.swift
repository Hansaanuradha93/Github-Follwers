import UIKit

class GFFollowerItemVC: GFItemInfoVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        congifureItems()
    }
    
    private func congifureItems() {
        itemInfoViewOne.setup(itemInfoType: .followers, withCount: user.followers ?? 0)
        itemInfoViewTwo.setup(itemInfoType: .following, withCount: user.following ?? 0)
        actionButton.setup(backgroundColor: .systemGreen, title: "Get Followers")
    }
    
    override func actionButtonTapped() {
        delegate.didTapGetFollowers(for: user)
    }
}
