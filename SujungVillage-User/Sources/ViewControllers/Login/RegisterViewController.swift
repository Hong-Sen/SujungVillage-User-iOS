//
//  RegisterViewController.swift
//  SujungVillage-User
//
//  Created by 홍세은 on 2022/10/09.
//

import UIKit

class RegisterViewController: UIViewController {
    private let registerView = RegisterView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        hideKeyboard()
        
        setupViews()
        setActions()
    }
    
    private func setupViews() {
        view.addSubview(registerView)
        registerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            registerView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            registerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            registerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            registerView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setActions() {
        registerView.setupPopVCHandler {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    
}
