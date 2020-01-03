//
//  GFAlertContainerView.swift
//  GitHubFollowers
//
//  Created by Hansa Anuradha on 1/2/20.
//  Copyright © 2020 Hansa Anuradha. All rights reserved.
//

import UIKit

class GFAlertContainerView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(frame: .zero)
        configure()
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor     = .systemBackground
        layer.cornerRadius  = 16
        layer.borderWidth   = 2
        layer.borderColor   = UIColor.white.cgColor
        
    }
    
}
