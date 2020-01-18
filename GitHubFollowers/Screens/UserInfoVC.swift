//
//  UserInfoVC.swift
//  GitHubFollowers
//
//  Created by Hansa Anuradha on 1/18/20.
//  Copyright © 2020 Hansa Anuradha. All rights reserved.
//

import UIKit

class UserInfoVC: UIViewController {

    var username: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor                = .systemBackground
        navigationItem.title                = username
        let dontButton                      = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem   = dontButton
    }
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }

}
