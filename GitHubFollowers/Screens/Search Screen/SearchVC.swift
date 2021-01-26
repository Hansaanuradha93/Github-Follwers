import UIKit

class SearchVC: UIViewController {

    // MARK: Properties
    private let logoImageView = UIImageView()
    private let usernameTextField = GFTextField()
    private let callToActionButton = GFButton(backgroundColor: .systemGreen, title: Strings.getFollowers)
    private var isUsernameEntered: Bool { return  !usernameTextField.text!.isEmpty }
    
    
    // MARK: View Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        resetUI()
    }
}


// MARK: - Private Methods
private extension SearchVC {
    
    @objc func pushFollwersViewController() {
        guard isUsernameEntered else {
            presentGFAlertOnMainTread(title: Strings.emptyUsername, message: Strings.pleaseEnterUsername, buttonTitle: Strings.ok)
            return
        }
        usernameTextField.resignFirstResponder()
        let follwersListVC = FollowersListVC(username: usernameTextField.text ?? "")
        navigationController?.pushViewController(follwersListVC, animated: true)
    }
    
    
    func resetUI() {
        navigationController?.setNavigationBarHidden(true, animated: true)
        usernameTextField.text = ""
        view.endEditing(true)
    }
    
    
    func configureUI() {
        view.backgroundColor = .systemBackground
        
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        
        view.addSubviews(logoImageView, usernameTextField, callToActionButton)

        logoImageView.image = Images.ghLogo
        usernameTextField.delegate = self
        callToActionButton.addTarget(self, action: #selector(pushFollwersViewController), for: .touchUpInside)
        
        let topConstraintConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 20 : 80
        let padding: CGFloat = 50
        let height: CGFloat = 50
        
        logoImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: topConstraintConstant, left: 0, bottom: 0, right: 0))
        logoImageView.centerHorizontallyInSuperView(size: .init(width: 200, height: 200))
        usernameTextField.anchor(top: logoImageView.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 48, left: padding, bottom: 0, right: padding), size: .init(width: 0, height: height))
        callToActionButton.anchor(top: nil, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: padding, bottom: padding, right: padding), size: .init(width: 0, height: height))
    }
}


// MARK: - UITextField Delegate
extension SearchVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushFollwersViewController()
        return true
    }
}
