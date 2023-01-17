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
        view.backgroundColor = .white
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
        
        registerView.setupPresentAlertHandler { type in
            switch type {
            case .overlapId:
                let alert = UIAlertController(title: "이미 사용중인 id입니다", message: nil, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))
                self.present(alert, animated: true)
            case .differentPwd:
                let alert = UIAlertController(title: "비밀번호가 일치하지 않습니다.", message: nil, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))
                self.present(alert, animated: true)

            case .noName:
                let alert = UIAlertController(title: "이름을 입력해주세요.", message: nil, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))
                self.present(alert, animated: true)

            case .noPhoneNumber:
                let alert = UIAlertController(title: "전화번호를 입력해주세요.", message: nil, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))
                self.present(alert, animated: true)

            case .unselectDormitory:
                let alert = UIAlertController(title: "기숙사를 선택해주세요.", message: nil, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))
                self.present(alert, animated: true)

            case .unwrittenRoom:
                let alert = UIAlertController(title: "기숙사 호실을 입력해주세요.", message: nil, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))
                self.present(alert, animated: true)

            case .notAgreeTerms:
                let alert = UIAlertController(title: "모든 약관에 동의해주세요.", message: nil, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))
                self.present(alert, animated: true)

            }
        }
    }
    
    
}
