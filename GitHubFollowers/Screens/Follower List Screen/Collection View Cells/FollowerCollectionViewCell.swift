import UIKit

class FollowerCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    static let reuseID              = "FollowerCell"
    private let avatarImageView     = GFAvatarImageView(frame: .zero)
    private let usernameLabel       = GFTitleLabel(textAlignment: .center, fontSize: 16)
    private let padding: CGFloat    = 8
    
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - Methods
extension FollowerCollectionViewCell {
    
    func set(follower: Follower) {
        usernameLabel.text = follower.login
        downloadAvatarImage(from: follower)
    }
    
    
    private func downloadAvatarImage(from follower: Follower) {
        NetworkManager.shared.downloadImage(from: follower.avatarUrl ?? "") { [weak self] image in
            guard let self          = self else { return }
            DispatchQueue.main.async { self.avatarImageView.image = image }
        }
    }
    
    
    private func configure() {
        addSubview(avatarImageView)
        addSubview(usernameLabel)

    
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            avatarImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
            
            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 12),
            usernameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            usernameLabel.widthAnchor.constraint(equalTo: avatarImageView.widthAnchor),
            usernameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
    }
}
