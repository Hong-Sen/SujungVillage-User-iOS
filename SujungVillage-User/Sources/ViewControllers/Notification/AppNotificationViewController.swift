//
//  AppNotificationViewController.swift
//  SujungVillage-User
//
//  Created by 홍세은 on 2022/12/16.
//

import UIKit

class AppNotificationViewController: UIViewController {

    let appNotiView = AppNotificationView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    private func setUI() {
        appNotiView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(appNotiView)
        NSLayoutConstraint.activate([
            appNotiView.topAnchor.constraint(equalTo: self.view.topAnchor),
            appNotiView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            appNotiView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            appNotiView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }

}
