import UIKit

class GFEmptyStateView: UIView {

    // MARK: Properties
    private let messageLabel = GFTitleLabel(textAlignment: .center, fontSize: 28)
    private let logoImageView = UIImageView()
    
    
    // MARK: Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    
    convenience init(message: String) {
        self.init(frame: .zero)
        messageLabel.text = message
    }
    
    
    required init?(coder: NSCoder) { fatalError() }
}


// MARK: - Private Methods
private extension GFEmptyStateView {
    
    func configureUI() {
        addSubviews(messageLabel, logoImageView)
        
        messageLabel.numberOfLines = 3
        messageLabel.textColor = .secondaryLabel
        logoImageView.image = Images.emptyState
        
        let topConstraintConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? -100 : -150
        let bottomConstraintConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 50  : 40
        let logoPadding: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 150 : 170
        let messagePadding: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 20 : 40
        let logoWidth: CGFloat = frame.width * 1.3

        messageLabel.anchor(top: nil, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: messagePadding, bottom: 0, right: messagePadding))
        messageLabel.centerVerticallyInSuperView(padding: topConstraintConstant)
        logoImageView.anchor(top: nil, leading: nil, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: bottomConstraintConstant, right: -logoPadding), size: .init(width: logoWidth, height: logoWidth))
    }
}
