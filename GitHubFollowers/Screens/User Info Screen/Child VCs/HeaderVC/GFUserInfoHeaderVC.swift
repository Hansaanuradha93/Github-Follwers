import UIKit

class GFUserInfoHeaderVC: UIViewController {

    // MARK: Properties
    private let avatarImageView = GFAvatarImageView(frame: .zero)
    private let usernameLabel = GFTitleLabel(textAlignment: .left, fontSize: 34)
    private let nameLabel = GFSecondaryTitleLabel(fontSize: 18)
    private let locationImageView = UIImageView()
    private let locationLabel = GFSecondaryTitleLabel(fontSize: 18)
    private let bioLabel = GFBodyLabel(textAlignment: .left)
    private var user: User!
    
    
    // MARK: Initializers
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    
    required init?(coder: NSCoder) { fatalError() }
    
    
    // MARK: View Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutUI()
        configureUIElements()
    }
}


// MARK: - Private Methods
private extension GFUserInfoHeaderVC {
    
    func configureUIElements() {
        usernameLabel.text = user.login ?? ""
        nameLabel.text = user.name ?? ""
        locationLabel.text = user.location ?? "No Location"
        bioLabel.text = user.bio ?? "No bio available"
        bioLabel.numberOfLines = 3
        locationImageView.image = SFSymbols.location
        locationImageView.tintColor = .secondaryLabel
        avatarImageView.downloadImage(fromUrl: user.avatarUrl ?? "")
    }
    
    
    func layoutUI() {
        let padding: CGFloat = 20
        let textImagePadding: CGFloat = 12

        view.addSubviews(avatarImageView, usernameLabel, nameLabel, locationImageView, locationLabel, bioLabel)
        
        avatarImageView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: padding, left: 0, bottom: 0, right: 0), size: .init(width: 90, height: 90))
        
        usernameLabel.anchor(top: avatarImageView.topAnchor, leading: avatarImageView.trailingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: textImagePadding, bottom: 0, right: padding))
        nameLabel.anchor(top: usernameLabel.bottomAnchor, leading: usernameLabel.leadingAnchor, bottom: nil, trailing: usernameLabel.trailingAnchor, padding: .init(top: 1, left: 0, bottom: 0, right: 0))
        
        locationImageView.anchor(top: nil, leading: nameLabel.leadingAnchor, bottom: avatarImageView.bottomAnchor, trailing: nil, size: .init(width: 20, height: 20))
        locationLabel.centerVertically(in: locationImageView)
        locationLabel.anchor(top: nil, leading: locationImageView.trailingAnchor, bottom: nil, trailing: nameLabel.trailingAnchor)
        
        bioLabel.anchor(top: avatarImageView.bottomAnchor, leading: avatarImageView.leadingAnchor, bottom: nil, trailing: usernameLabel.trailingAnchor, padding: .init(top: padding, left: 0, bottom: 0, right: 0))
    }
}
