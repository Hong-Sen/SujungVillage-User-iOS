//
//  NotificationMainView.swift
//  SujungVillage-User
//
//  Created by 홍세은 on 2022/12/13.
//

import UIKit

class NotificationMainView: UIView{

    private lazy var navigationBarView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var backBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        btn.tintColor = .black
        btn.addTarget(self, action: #selector(backBtnSelected), for: .touchUpInside)
        return btn
    }()
    
    private lazy var notificationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .text_black
        label.font = UIFont.suit(size: 22, family: .SemiBold)
        label.text = "알림"
        return label
    }()
    
    var popVCHandler: (() -> Void)?
    
    func setupPopVCHandler(_ handler: @escaping() -> Void) {
        popVCHandler = handler
    }
    
    init() {
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        setupNaviBarView()
        setupBackBtn()
        setupNotificationLabel()
    }
    
    private func setupNaviBarView() {
        addSubview(navigationBarView)
        NSLayoutConstraint.activate([
            navigationBarView.topAnchor.constraint(equalTo:topAnchor),
            navigationBarView.leadingAnchor.constraint(equalTo: leadingAnchor),
            navigationBarView.trailingAnchor.constraint(equalTo: trailingAnchor),
            navigationBarView.heightAnchor.constraint(equalToConstant: 90)
        ])
    }
    
    private func setupBackBtn() {
        navigationBarView.addSubview(backBtn)
        NSLayoutConstraint.activate([
            backBtn.bottomAnchor.constraint(equalTo: navigationBarView.bottomAnchor, constant: -10),
            backBtn.leadingAnchor.constraint(equalTo: navigationBarView.leadingAnchor, constant: 15)
        ])
    }
    
    private func setupNotificationLabel() {
        navigationBarView.addSubview(notificationLabel)
        NSLayoutConstraint.activate([
            notificationLabel.bottomAnchor.constraint(equalTo: navigationBarView.bottomAnchor, constant: -10),
            notificationLabel.centerXAnchor.constraint(equalTo: navigationBarView.centerXAnchor)
        ])
    }
    
    @objc func backBtnSelected() {
        popVCHandler?()
    }

}
