//
//  FollwersListViewController.swift
//  GitHubFollowers
//
//  Created by Hansa Anuradha on 1/1/20.
//  Copyright © 2020 Hansa Anuradha. All rights reserved.
//

import UIKit

class FollwersListViewController: UIViewController {

    var username: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.isNavigationBarHidden = false // Get back the navigation bar
        navigationController?.navigationBar.prefersLargeTitles = true // Get large titles
    }

}
