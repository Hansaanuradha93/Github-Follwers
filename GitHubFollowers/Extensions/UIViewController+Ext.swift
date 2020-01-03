//
//  UIViewController+Ext.swift
//  GitHubFollowers
//
//  Created by Hansa Anuradha on 1/3/20.
//  Copyright © 2020 Hansa Anuradha. All rights reserved.
//

import UIKit

extension UIViewController {
    func presentGFAlertOnMainTread(title: String, message: String, buttonTitle: String) {
        
        DispatchQueue.main.async {
            let alertVC = GFAlertVC(title: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true, completion: nil)
        }
    }
}
