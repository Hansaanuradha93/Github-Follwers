import UIKit

class UserInfoVC: UIViewController {

    
    let headerView = UIView()
    var username: String!
    
    
    init(username: String) {
        super.init(nibName: nil, bundle: nil)
        self.username = username
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureNavigationbar()
        layoutUI()
        getUserInfo(username: username)
    }
    
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
    
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
    }
    
    
    private func configureNavigationbar() {
        navigationItem.title                = username
        let dontButton                      = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem   = dontButton
    }
    
    
    private func getUserInfo(username: String) {
        self.showLoadingView()
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
        guard let self = self else { return }
            self.dismissLoadingView()
            
            switch result {
            case .success(let user):
                print(user)
            
            case .failure(let error):
                print(error)
                self.presentGFAlertOnMainTread(title: "Bad Stuff Happened", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }
    
    
    private func layoutUI() {
        let padding: CGFloat = 20
        
        view.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        headerView.backgroundColor = .systemRed
        
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            headerView.heightAnchor.constraint(equalToConstant: 180)
        ])
    }

}
