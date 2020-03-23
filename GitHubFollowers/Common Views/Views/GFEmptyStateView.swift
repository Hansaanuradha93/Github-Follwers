import UIKit

class GFEmptyStateView: UIView {

    // MARK: - Properties
    private let messageLabel            = GFTitleLabel(textAlignment: .center, fontSize: 28)
    private let logoImageView           = UIImageView()
    
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureMessageLabel()
        configureLogoImageView()
    }
    
    
    convenience init(message: String) {
        self.init(frame: .zero)
        messageLabel.text = message
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - Private Methods
extension GFEmptyStateView {
    
    private func configureMessageLabel() {
        addSubview(messageLabel)
        messageLabel.numberOfLines  = 3
        messageLabel.textColor      = .secondaryLabel
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let topConstraintConstant: CGFloat  = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? -100  : -150
        let padding: CGFloat                = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 20    : 40


        NSLayoutConstraint.activate([
            messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: topConstraintConstant),
            messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            messageLabel.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    
    private func configureLogoImageView() {
        addSubview(logoImageView)
        logoImageView.image = Images.emptyState
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let bottomConstraintConstant: CGFloat   = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 50  : 40
        let padding: CGFloat                    = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 150 : 170
        
        NSLayoutConstraint.activate([
            logoImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            logoImageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            logoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: padding),
            logoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: bottomConstraintConstant)
        ])
    }
}
