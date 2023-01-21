//
//  SettingViewController.swift
//  SujungVillage-User
//
//  Created by 홍세은 on 2022/09/28.
//

import UIKit

class SettingViewController: UIViewController {
    private let viewModel = UserInfoViewModel.shared
    private let defaults = UserDefaults.standard
    private var settingView = SettingView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        setupViews()
        setupActions()
        fetchView()
        viewModel.fetchResidentInfo(year: Calendar.current.component(.year, from: Date()), month: Calendar.current.component(.month, from: Date()))
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchView()
        viewModel.fetchResidentInfo(year: Calendar.current.component(.year, from: Date()), month: Calendar.current.component(.month, from: Date()))
    }
    
    private func setupViews() {
        view.addSubview(settingView)
        settingView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            settingView.topAnchor.constraint(equalTo: view.topAnchor),
            settingView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            settingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            settingView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setupActions() {
        settingView.setupPushNotificationVCHandler {
            let notificationVC = NotificationViewController()
            self.navigationController?.pushViewController(notificationVC, animated: true)
        }
        
        settingView.setupTabViewHandler { type in
            switch type {
            case .deleteAccount:
                let alert = UIAlertController(title: "정말 탈퇴 하시겠습니까?", message: nil, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "탈퇴하기", style: .default, handler: { UIAlertAction in
                    // FIX
                }))
                alert.addAction(UIAlertAction(title: "취소", style: .destructive, handler: nil))
                self.present(alert, animated: true)
                return
            case .inquiry:
                let alert = UIAlertController(title: "해당 이메일로 문의 주세요.", message: "sujungvillage@gmail.com", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "확인", style: .default))
                self.present(alert, animated: true)
                return
            case .logout:
                let alert = UIAlertController(title: "로그아웃 하시겠습니까?", message: nil, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "확인", style: .default, handler: { UIAlertAction in
                    UserDefaults.standard.autoLogin = false
                    UserDefaults.standard.needLogin = true
                    NotificationCenter.default.post(name: Notification.Name("showHomeTab"), object: nil)
                }))
                alert.addAction(UIAlertAction(title: "취소", style: .destructive, handler: nil))
                self.present(alert, animated: true)
                return
            }
        }
    }
    
    func fetchView() {
        viewModel.onUpdated = {[weak self] in
            DispatchQueue.main.async { [self] in
                self?.settingView.nameLabel.text = self?.viewModel.userName
                if let dormitory = self?.viewModel.dormitoryName,
                   let detailedAddress = self?.viewModel.detailedAddress {
                    self?.settingView.dormitoryInfoLabel.text = "\(dormitory) | \(detailedAddress)"
                }
            }
        }
    }
    
    @objc func alarmBtnSelected() {
        let notificationVC = NotificationViewController()
        self.navigationController?.pushViewController(notificationVC, animated: true)
    }
}
