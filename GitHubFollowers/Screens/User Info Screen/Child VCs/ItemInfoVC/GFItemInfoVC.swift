import UIKit

class GFItemInfoVC: UIViewController {

    // MARK: Properties
    let itemInfoViewOne = GFItemView()
    let itemInfoViewTwo = GFItemView()
    let actionButton = GFButton()
    var user: User!
    
    
    // MARK: Initializers
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    
    required init?(coder: NSCoder) { fatalError() }
    
    
    // MARK: View Controllers
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
}


// MARK: - Objc Methods
extension GFItemInfoVC {

    @objc func actionButtonTapped() {}
}


// MARK: - Private Methods
private extension GFItemInfoVC {
    
    func configureUI() {
        view.layer.cornerRadius = 18
        view.backgroundColor = .secondarySystemBackground
        
        actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        
        let padding: CGFloat = 20

        let stackView = UIStackView(arrangedSubviews: [itemInfoViewOne, itemInfoViewTwo])
        stackView.distribution = .equalSpacing
        view.addSubviews(stackView, actionButton)
                
        stackView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: padding, left: padding, bottom: 0, right: padding), size: .init(width: 0, height: 50))
        actionButton.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: padding, bottom: padding, right: padding), size: .init(width: 0, height: 44))
    }
}
