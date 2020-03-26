import UIKit

// MARK: - Enums
enum ItemInfoType {
    
    case repos, gists, followers, following
}


class GFItemView: UIView {
    
    // MARK: - Properties
    private let symbolImageView = UIImageView()
    private let titleLabel      = GFTitleLabel(textAlignment: .left, fontSize: 14)
    private let countLabel      = GFTitleLabel(textAlignment: .center, fontSize: 14)
    
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    } 
}


// MARK: - Private Methods

extension GFItemView {
    
    func setup(itemInfoType: ItemInfoType, withCount count: Int) {
        switch itemInfoType {
        case .repos:
            symbolImageView.image   = SFSymbols.repos
            titleLabel.text         = "Public Repos"
        case .gists:
            symbolImageView.image   = SFSymbols.gists
            titleLabel.text         = "Public Gists"
        case .followers:
            symbolImageView.image   = SFSymbols.followers
            titleLabel.text         = "Followers"
        case .following:
            symbolImageView.image   = SFSymbols.followings
            titleLabel.text         = "Following"
        }
        countLabel.text             = "\(count)"
    }
    
    
    private func configure() {
        addSubviews(symbolImageView, titleLabel, countLabel)
        
        symbolImageView.translatesAutoresizingMaskIntoConstraints = false
        symbolImageView.contentMode = .scaleAspectFill
        symbolImageView.tintColor   = .label
        
        NSLayoutConstraint.activate([
            symbolImageView.topAnchor.constraint(equalTo: self.topAnchor),
            symbolImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            symbolImageView.widthAnchor.constraint(equalToConstant: 20),
            symbolImageView.heightAnchor.constraint(equalToConstant: 20),
            
            titleLabel.centerYAnchor.constraint(equalTo: symbolImageView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: symbolImageView.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 18),
            
            countLabel.topAnchor.constraint(equalTo: symbolImageView.bottomAnchor, constant: 4),
            countLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            countLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            countLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
}
