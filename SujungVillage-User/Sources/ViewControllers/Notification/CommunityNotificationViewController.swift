//
//  CommunityNotificationViewController.swift
//  SujungVillage-User
//
//  Created by 홍세은 on 2022/12/16.
//

import UIKit

class CommunityNotificationViewController: UIViewController {
    
    let communityNotiView = CommunityNotificationView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    private func setUI() {
        communityNotiView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(communityNotiView)
        NSLayoutConstraint.activate([
            communityNotiView.topAnchor.constraint(equalTo: self.view.topAnchor),
            communityNotiView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            communityNotiView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            communityNotiView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
}
