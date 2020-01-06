//
//  FollwersListViewController.swift
//  GitHubFollowers
//
//  Created by Hansa Anuradha on 1/1/20.
//  Copyright © 2020 Hansa Anuradha. All rights reserved.
//

import UIKit

class FollwersListVC: UIViewController {

    var username: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true // Get large titles
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(false, animated: true) // Show the navigation bar
    }

}
