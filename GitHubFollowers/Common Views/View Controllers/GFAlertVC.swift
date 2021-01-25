import UIKit

class GFAlertVC: UIViewController {
    
    // MARK: Properties
    private let containerView = GFAlertContainerView()
    private let titleLabel = GFTitleLabel(textAlignment: .center, fontSize: 20)
    private let messageLabel = GFBodyLabel(textAlignment: .center)
    private let actionButton = GFButton(backgroundColor: .systemPink, title: Strings.ok)
    
    private var alertTitle: String?
    private var message: String?
    private var buttonTitle: String?
    private let padding: CGFloat = 20
    
    
    // MARK: Initializers
    init(title: String, message: String, buttonTitle: String) {
        super.init(nibName: nil, bundle: nil)
        self.alertTitle = title
        self.message = message
        self.buttonTitle = buttonTitle
    }
    
    
    required init?(coder: NSCoder) { fatalError() }
    
    
    // MARK: View Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
}


// MARK: - Private Methods
private extension GFAlertVC {
    
    @objc func dismissAlert() {
        dismiss(animated: true, completion: nil)
    }
    
    
    func configureUI() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        
        titleLabel.text = alertTitle ?? Strings.somethingWentWrong
        messageLabel.text = message ?? Strings.unableToCompleteTheRequest
        messageLabel.numberOfLines = 4
        actionButton.setTitle(buttonTitle ?? Strings.ok, for: .normal)
        actionButton.addTarget(self, action: #selector(dismissAlert), for: .touchUpInside)
        
        view.addSubviews(containerView, titleLabel, messageLabel, actionButton)
        
        containerView.centerInSuperview(size: .init(width: 280, height: 230))
        titleLabel.anchor(top: containerView.topAnchor, leading: containerView.leadingAnchor, bottom: nil, trailing: containerView.trailingAnchor, padding: .init(top: padding, left: padding, bottom: 0, right: padding))
        actionButton.anchor(top: nil, leading: containerView.leadingAnchor, bottom: containerView.bottomAnchor, trailing: containerView.trailingAnchor, padding: .init(top: 0, left: padding, bottom: padding, right: padding), size: .init(width: 0, height: 44))
        messageLabel.anchor(top: titleLabel.bottomAnchor, leading: containerView.leadingAnchor, bottom: actionButton.topAnchor, trailing: containerView.trailingAnchor, padding: .init(top: 8, left: padding, bottom: 12, right: padding))
    }
}
