import UIKit

class UserInfoVC: UIViewController {
    
    let headerView  = UIView()
    let itemView1   = UIView()
    let itemView2   = UIView()
    
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
                DispatchQueue.main.async { self.add(childVC: GFUserInfoHeaderVC(user: user), to: self.headerView) }
            
            case .failure(let error):
                print(error)
                self.presentGFAlertOnMainTread(title: "Bad Stuff Happened", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }
    
    
    private func layoutUI() {
        let padding: CGFloat    = 20
        let itemHeight: CGFloat = 140
        
        view.addSubview(headerView)
        view.addSubview(itemView1)
        view.addSubview(itemView2)

        headerView.translatesAutoresizingMaskIntoConstraints = false
        itemView1.translatesAutoresizingMaskIntoConstraints = false
        itemView2.translatesAutoresizingMaskIntoConstraints = false
        
        itemView1.backgroundColor = .systemRed
        itemView2.backgroundColor = .systemBlue

        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            itemView1.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemView1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            itemView1.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            itemView1.heightAnchor.constraint(equalToConstant: itemHeight),
            
            itemView2.topAnchor.constraint(equalTo: itemView1.bottomAnchor, constant: padding),
            itemView2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            itemView2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            itemView2.heightAnchor.constraint(equalToConstant: itemHeight)
        ])
    }
    
    
    private func add(childVC: UIViewController, to containerView: UIView) {
        self.addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }

}
