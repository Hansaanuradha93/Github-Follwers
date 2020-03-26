import UIKit

class SearchVC: UIViewController {

    // MARK: - Properties
    private let logoImageView       = UIImageView()
    private let usernameTextField   = GFTextField()
    private let callToActionButton  = GFButton(backgroundColor: .systemGreen, title: "Get Follwers")
    private var isUsernameEntered: Bool { return  !usernameTextField.text!.isEmpty }
    
    
    // MARK: - View Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureUIElements()
        createTapGesture()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        usernameTextField.text = ""
        view.endEditing(true)
    }
}


// MARK: - Private Methods
extension SearchVC {
    
    private func createTapGesture() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    
    @objc func pushFollwersViewController() {
        guard isUsernameEntered else {
            presentGFAlertOnMainTread(title: "Empty Username", message: "Please enter a username. We need to know who to look for 😀.", buttonTitle: "Ok")
            return
        }
        usernameTextField.resignFirstResponder()
        let follwersListVC      = FollowersListVC(username: usernameTextField.text ?? "")
        navigationController?.pushViewController(follwersListVC, animated: true)
    }
    
    
    private func configureUIElements() {
        view.addSubviews(logoImageView, usernameTextField, callToActionButton)

        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = Images.ghLogo
        
        usernameTextField.delegate = self

        callToActionButton.addTarget(self, action: #selector(pushFollwersViewController), for: .touchUpInside)
        
        let topConstraintConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 20 : 80

        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topConstraintConstant),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200),
            
            usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            usernameTextField.heightAnchor.constraint(equalToConstant: 50),
            
            callToActionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            callToActionButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}


// MARK: - UITextField Delegate
extension SearchVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushFollwersViewController()
        return true
    }
}
