import UIKit

// MARK: Enums
enum ItemInfoType {
    case repos, gists, followers, following
}


class GFItemView: UIView {
    
    // MARK: Properties
    private let symbolImageView = UIImageView()
    private let titleLabel = GFTitleLabel(textAlignment: .left, fontSize: 14)
    private let countLabel = GFTitleLabel(textAlignment: .center, fontSize: 14)
    
    
    // MARK: Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) { fatalError() }
}


// MARK: - Private Methods
extension GFItemView {
    
    func setup(itemInfoType: ItemInfoType, withCount count: Int) {
        switch itemInfoType {
        case .repos:
            symbolImageView.image = SFSymbols.repos
            titleLabel.text = Strings.publicRepos
        case .gists:
            symbolImageView.image = SFSymbols.gists
            titleLabel.text = Strings.publicGists
        case .followers:
            symbolImageView.image = SFSymbols.followers
            titleLabel.text = Strings.followers
        case .following:
            symbolImageView.image = SFSymbols.followings
            titleLabel.text = Strings.following
        }
        countLabel.text = "\(count)"
    }
    
    
    private func configure() {
        addSubviews(symbolImageView, titleLabel, countLabel)
        
        symbolImageView.contentMode = .scaleAspectFill
        symbolImageView.tintColor = .label
        
        symbolImageView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, size: .init(width: 20, height: 20))
        titleLabel.centerVertically(in: symbolImageView)
        titleLabel.anchor(top: nil, leading: symbolImageView.trailingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 12, bottom: 0, right: 0))
        countLabel.anchor(top: symbolImageView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 4, left: 0, bottom: 0, right: 0))
    }
}
