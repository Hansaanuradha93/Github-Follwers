import UIKit

class GFAlertVC: UIViewController {
    
    // MARK: Properties
    private let containerView = GFAlertContainerView()
    private let titleLabel = GFTitleLabel(textAlignment: .center, fontSize: 20)
    private let messageLabel = GFBodyLabel(textAlignment: .center)
    private let actionButton = GFButton(backgroundColor: .systemPink, title: "Ok")
    
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
        configureViewController()
        addSubviews()
        configureContainerView()
        configureTitleLabel()
        configureActionButtonn()
        configureMessageLabel()
    }
}


// MARK: - Private Methods
private extension GFAlertVC {
    
    @objc func dismissAlert() {
        dismiss(animated: true, completion: nil)
    }
    
    
    func configureViewController() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
    }
   
    
    func addSubviews() {
        view.addSubviews(containerView, titleLabel, messageLabel, actionButton)
    }
 
    
    func configureContainerView() {
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 280),
            containerView.heightAnchor.constraint(equalToConstant: 230)
        ])
    }
    
    
    func configureTitleLabel() {
        titleLabel.text = alertTitle ?? "Something went wrong!"
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 28)
        ])
    }
    
    
    func configureMessageLabel() {
        messageLabel.text = message ?? "Unable to complete request"
        messageLabel.numberOfLines = 4
        
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            messageLabel.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: -12)
        ])
    }
    
    
    func configureActionButtonn() {
        actionButton.setTitle(buttonTitle ?? "Ok", for: .normal)
        actionButton.addTarget(self, action: #selector(dismissAlert), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            actionButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}
