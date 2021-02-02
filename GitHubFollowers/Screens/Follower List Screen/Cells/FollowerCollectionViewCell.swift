import UIKit

class FollowerCollectionViewCell: UICollectionViewCell {
    
    // MARK: Properties
    static let reuseID = "FollowerCell"
    private let avatarImageView = GFAvatarImageView(frame: .zero)
    private let usernameLabel = GFTitleLabel(textAlignment: .center, fontSize: 16)
    
    
    // MARK: Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) { fatalError() }
}


// MARK: - Methods
extension FollowerCollectionViewCell {
    
    func set(follower: Follower) {
        usernameLabel.text = follower.login
        avatarImageView.downloadImage(fromUrl: follower.avatarUrl ?? "")
    }
    
    
    private func configure() {
        addSubviews(avatarImageView, usernameLabel)
        
        let padding: CGFloat = 8
        let dimensions = contentView.frame.width - 2 * padding
        
        avatarImageView.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor, padding: .init(top: padding, left: padding, bottom: 0, right: padding), size: .init(width: 0, height: dimensions))
        usernameLabel.anchor(top: avatarImageView.bottomAnchor, leading: avatarImageView.leadingAnchor, bottom: nil, trailing: avatarImageView.trailingAnchor, padding: .init(top: 12, left: 0, bottom: 0, right: 0))
    }
}
