import UIKit

class GFRepoItemVC: GFItemInfoVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        congifureItems()
    }
    
    private func congifureItems() {
        itemInfoViewOne.setup(itemInfoType: .repos, withCount: user.publicRepos ?? 0)
        itemInfoViewTwo.setup(itemInfoType: .gists, withCount: user.publicGists ?? 0)
        actionButton.setup(backgroundColor: .systemPurple, title: "Github Profile")
    }
}
