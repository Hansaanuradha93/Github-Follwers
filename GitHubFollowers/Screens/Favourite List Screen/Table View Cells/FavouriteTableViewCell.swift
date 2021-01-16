import UIKit

class FavouriteTableViewCell: UITableViewCell {

    // MARK: Properties
    static let reuseID = "FavouriteCell"
    private let avatarImageView = GFAvatarImageView(frame: .zero)
    private let usernameLabel = GFTitleLabel(textAlignment: .left, fontSize: 26)
    
    
    // MARK: Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    
    required init?(coder: NSCoder) { fatalError() }
}


// MARK: - Private Methods
extension FavouriteTableViewCell {
    
    func set(favourite: Follower) {
        usernameLabel.text = favourite.login
        avatarImageView.downloadImage(fromUrl: favourite.avatarUrl ?? "")
    }
    
    
    private func configure() {
        addSubviews(avatarImageView, usernameLabel)
        
        accessoryType = .disclosureIndicator
        let padding: CGFloat = 12
        
        avatarImageView.anchor(top: nil, leading: contentView.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: padding, bottom: 0, right: 0), size: .init(width: 60, height: 60))
        avatarImageView.centerVerticallyInSuperView()
        usernameLabel.anchor(top: nil, leading: avatarImageView.trailingAnchor, bottom: nil, trailing: contentView.trailingAnchor, padding: .init(top: 0, left: 2 * padding, bottom: 0, right: padding))
        usernameLabel.centerVerticallyInSuperView()
    }
}
