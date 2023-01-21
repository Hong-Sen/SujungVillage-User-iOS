//
//  SettingView.swift
//  SujungVillage-User
//
//  Created by 홍세은 on 2023/01/21.
//

import UIKit

class SettingView: UIView {
    
    private lazy var navigationBarView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var alarmBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "icon_bell_black"), for: .normal)
        btn.tintColor = .black
        btn.addTarget(self, action: #selector(alarmBtnSelected), for: .touchUpInside)
        return btn
    }()
    
    private lazy var settingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .text_black
        label.font = UIFont.suit(size: 20, family: .SemiBold)
        label.text = "설정"
        return label
    }()
    
    private lazy var infoView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 15)
        view.addShadow(location: .bottom, opacity: 0.15, radius: 15)
        return view
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .text_black
        label.textAlignment = .center
        label.text = "000"
        label.font = UIFont.suit(size: 20, family: .SemiBold)
        return label
    }()
    
    private lazy var identityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .text_gray
        label.textAlignment = .center
        label.text = "재사생"
        label.font = UIFont.suit(size: 14, family: .Medium)
        return label
    }()
    
    private lazy var dormitoryImg: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "icon_dormitory")
        return img
    }()
    
    lazy var dormitoryInfoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .text_gray
        label.textAlignment = .center
        label.text = "000"
        label.font = UIFont.suit(size: 14, family: .Medium)
        return label
    }()
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    private lazy var settingListView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var alarmLine = UIView()
    private lazy var alarmSettingLabel = UILabel()
    private lazy var alarmSwitch: UISwitch = {
        let swt = UISwitch()
        swt.translatesAutoresizingMaskIntoConstraints = false
        swt.onTintColor = .primary
        swt.addTarget(self, action: #selector(onClickAlarmSwitch(sender:)), for: .valueChanged)
        return swt
    }()
    
    private lazy var deleteAccountLine = UIView()
    private lazy var deleteAccountView = UIView()
    private lazy var deleteAccountLabel = UILabel()
    private lazy var deleteAccountNextImg = UIImageView()
    
    private lazy var inquiryLine = UIView()
    private lazy var inquiryView = UIView()
    private lazy var inquiryLabel = UILabel()
    private lazy var inquiryNextImg = UIImageView()
    
    private lazy var logoutLine = UIView()
    private lazy var logoutView = UIView()
    private lazy var logoutLabel = UILabel()
    private lazy var logoutNextImg = UIImageView()
    
    private let defaults = UserDefaults.standard
    var pushNotificationVCHandler: (() -> Void)?
    var tabViewHandler: ((SettingType) -> Void)?
    
    init() {
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupPushNotificationVCHandler(_ handler: @escaping() -> Void) {
        pushNotificationVCHandler = handler
    }
    
    func setupTabViewHandler(_ handler: @escaping(SettingType) -> Void) {
        tabViewHandler = handler
    }
    
    private func setupViews() {
        setupNavibar()
        setupScrollView()
        setupSettingListView()
        setupInfoView()
        setupAlarmView()
        setupDeleteAccountView()
        setupInquiryView()
        setupLogoutView()
        addGesture()
        setNotification()
    }
    
    private func setupNavibar() {
        addSubview(navigationBarView)
        NSLayoutConstraint.activate([
            navigationBarView.leadingAnchor.constraint(equalTo: leadingAnchor),
            navigationBarView.trailingAnchor.constraint(equalTo: trailingAnchor),
            navigationBarView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            navigationBarView.heightAnchor.constraint(equalToConstant: 45)
        ])
        
        navigationBarView.addSubview(settingLabel)
        NSLayoutConstraint.activate([
            settingLabel.centerYAnchor.constraint(equalTo: navigationBarView.centerYAnchor),
            settingLabel.centerXAnchor.constraint(equalTo: navigationBarView.centerXAnchor)
        ])
        
        navigationBarView.addSubview(alarmBtn)
        NSLayoutConstraint.activate([
            alarmBtn.centerYAnchor.constraint(equalTo: navigationBarView.centerYAnchor),
            alarmBtn.trailingAnchor.constraint(equalTo: navigationBarView.trailingAnchor, constant: -26),
            alarmBtn.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    private func setupScrollView() {
        addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: navigationBarView.bottomAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setupSettingListView() {
        scrollView.addSubview(settingListView)
        
        NSLayoutConstraint.activate([
            settingListView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            settingListView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            settingListView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            settingListView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor)
        ])
        
        settingListView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        let settingListViewHeight = settingListView.heightAnchor.constraint(greaterThanOrEqualTo: heightAnchor)
        settingListViewHeight.priority = .defaultLow
        settingListViewHeight.isActive = true
    }
    
    private func setupInfoView() {
        settingListView.addSubview(infoView)
        
        NSLayoutConstraint.activate([
            infoView.topAnchor.constraint(equalTo: settingListView.topAnchor, constant: 0),
            infoView.leftAnchor.constraint(equalTo: settingListView.leftAnchor, constant: 0),
            infoView.rightAnchor.constraint(equalTo: settingListView.rightAnchor, constant: 0),
            infoView.heightAnchor.constraint(equalToConstant: 90)
        ])
        
        infoView.addSubview(nameLabel)
        infoView.addSubview(identityLabel)
        infoView.addSubview(dormitoryImg)
        infoView.addSubview(dormitoryInfoLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: infoView.topAnchor, constant: 21),
            nameLabel.leftAnchor.constraint(equalTo: infoView.leftAnchor, constant: 42)
        ])
        
        NSLayoutConstraint.activate([
            identityLabel.topAnchor.constraint(equalTo: infoView.topAnchor, constant: 27),
            identityLabel.leftAnchor.constraint(equalTo: nameLabel.rightAnchor, constant: 6),
        ])
        
        NSLayoutConstraint.activate([
            dormitoryImg.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 9),
            dormitoryImg.leftAnchor.constraint(equalTo: infoView.leftAnchor, constant: 42),
        ])
        
        NSLayoutConstraint.activate([
            dormitoryInfoLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 7),
            dormitoryInfoLabel.leftAnchor.constraint(equalTo: dormitoryImg.rightAnchor, constant: 5),
        ])
    }
    
    private func setupAlarmView() {
        alarmSettingLabel = setSettingListLabel(text: "알림 설정")
        settingListView.addSubview(alarmSettingLabel)
        NSLayoutConstraint.activate([
            alarmSettingLabel.topAnchor.constraint(equalTo: infoView.bottomAnchor, constant: 44),
            alarmSettingLabel.leadingAnchor.constraint(equalTo: settingListView.leadingAnchor, constant: 40)
        ])
        
        settingListView.addSubview(alarmSwitch)
        NSLayoutConstraint.activate([
            alarmSwitch.topAnchor.constraint(equalTo: infoView.bottomAnchor, constant: 44),
            alarmSwitch.trailingAnchor.constraint(equalTo: settingListView.trailingAnchor, constant: -40)
        ])
        
        alarmLine = setLine()
        settingListView.addSubview(alarmLine)
        NSLayoutConstraint.activate([
            alarmLine.topAnchor.constraint(equalTo: alarmSettingLabel.bottomAnchor, constant: 30),
            alarmLine.leadingAnchor.constraint(equalTo: settingListView.leadingAnchor, constant: 0),
            alarmLine.trailingAnchor.constraint(equalTo: settingListView.trailingAnchor, constant: 0),
            alarmLine.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    private func setupDeleteAccountView() {
        deleteAccountView = setSettingListView()
        settingListView.addSubview(deleteAccountView)
        NSLayoutConstraint.activate([
            deleteAccountView.topAnchor.constraint(equalTo: alarmLine.bottomAnchor),
            deleteAccountView.leftAnchor.constraint(equalTo: settingListView.leftAnchor),
            deleteAccountView.rightAnchor.constraint(equalTo: settingListView.rightAnchor),
            deleteAccountView.heightAnchor.constraint(equalToConstant: 84)
        ])
        
        deleteAccountLabel = setSettingListLabel(text: "회원탈퇴")
        deleteAccountView.addSubview(deleteAccountLabel)
        
        NSLayoutConstraint.activate([
            deleteAccountLabel.centerYAnchor.constraint(equalTo: deleteAccountView.centerYAnchor),
            deleteAccountLabel.leftAnchor.constraint(equalTo: deleteAccountView.leftAnchor, constant: 40)
        ])
        
        deleteAccountNextImg = setSettingNextBtn()
        deleteAccountView.addSubview(deleteAccountNextImg)
        
        NSLayoutConstraint.activate([
            deleteAccountNextImg.widthAnchor.constraint(equalToConstant: 22),
            deleteAccountNextImg.heightAnchor.constraint(equalToConstant: 22),
            deleteAccountNextImg.centerYAnchor.constraint(equalTo: deleteAccountView.centerYAnchor),
            deleteAccountNextImg.trailingAnchor.constraint(equalTo: deleteAccountView.trailingAnchor, constant: -40)
        ])
        
        deleteAccountLine = setLine()
        settingListView.addSubview(deleteAccountLine)
        NSLayoutConstraint.activate([
            deleteAccountLine.topAnchor.constraint(equalTo: deleteAccountView.bottomAnchor, constant: 0),
            deleteAccountLine.leadingAnchor.constraint(equalTo: settingListView.leadingAnchor, constant: 0),
            deleteAccountLine.trailingAnchor.constraint(equalTo: settingListView.trailingAnchor, constant: 0),
            deleteAccountLine.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    private func setupInquiryView() {
        inquiryView = setSettingListView()
        settingListView.addSubview(inquiryView)
        NSLayoutConstraint.activate([
            inquiryView.topAnchor.constraint(equalTo: deleteAccountLine.bottomAnchor, constant: 0),
            inquiryView.leftAnchor.constraint(equalTo: settingListView.leftAnchor, constant: 0),
            inquiryView.rightAnchor.constraint(equalTo: settingListView.rightAnchor, constant: 0),
            inquiryView.heightAnchor.constraint(equalToConstant: 84)
        ])
        
        inquiryLabel = setSettingListLabel(text: "앱 문의하기")
        inquiryView.addSubview(inquiryLabel)
        
        NSLayoutConstraint.activate([
            inquiryLabel.centerYAnchor.constraint(equalTo: inquiryView.centerYAnchor),
            inquiryLabel.leftAnchor.constraint(equalTo: inquiryView.leftAnchor, constant: 40)
        ])
        
        inquiryNextImg = setSettingNextBtn()
        inquiryView.addSubview(inquiryNextImg)
        
        NSLayoutConstraint.activate([
            inquiryNextImg.widthAnchor.constraint(equalToConstant: 22),
            inquiryNextImg.heightAnchor.constraint(equalToConstant: 22),
            inquiryNextImg.centerYAnchor.constraint(equalTo: inquiryView.centerYAnchor),
            inquiryNextImg.trailingAnchor.constraint(equalTo: inquiryView.trailingAnchor, constant: -40)
        ])
        
        inquiryLine = setLine()
        settingListView.addSubview(inquiryLine)
        NSLayoutConstraint.activate([
            inquiryLine.topAnchor.constraint(equalTo: inquiryView.bottomAnchor, constant: 0),
            inquiryLine.leadingAnchor.constraint(equalTo: settingListView.leadingAnchor, constant: 0),
            inquiryLine.trailingAnchor.constraint(equalTo: settingListView.trailingAnchor, constant: 0),
            inquiryLine.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    private func setupLogoutView() {
        logoutView = setSettingListView()
        settingListView.addSubview(logoutView)
        NSLayoutConstraint.activate([
            logoutView.topAnchor.constraint(equalTo: inquiryLine.bottomAnchor, constant: 0),
            logoutView.leftAnchor.constraint(equalTo: settingListView.leftAnchor, constant: 0),
            logoutView.rightAnchor.constraint(equalTo: settingListView.rightAnchor, constant: 0),
            logoutView.heightAnchor.constraint(equalToConstant: 84)
        ])
        
        logoutLabel = setSettingListLabel(text: "로그아웃")
        logoutView.addSubview(logoutLabel)
        
        NSLayoutConstraint.activate([
            logoutLabel.centerYAnchor.constraint(equalTo: logoutView.centerYAnchor),
            logoutLabel.leftAnchor.constraint(equalTo: logoutView.leftAnchor, constant: 40)
        ])
        
        logoutNextImg = setSettingNextBtn()
        logoutView.addSubview(logoutNextImg)
        
        NSLayoutConstraint.activate([
            logoutNextImg.widthAnchor.constraint(equalToConstant: 22),
            logoutNextImg.heightAnchor.constraint(equalToConstant: 22),
            logoutNextImg.centerYAnchor.constraint(equalTo: logoutView.centerYAnchor),
            logoutNextImg.trailingAnchor.constraint(equalTo: logoutView.trailingAnchor, constant: -40)
        ])
        
        logoutLine = setLine()
        settingListView.addSubview(logoutLine)
        NSLayoutConstraint.activate([
            logoutLine.topAnchor.constraint(equalTo: logoutView.bottomAnchor, constant: 0),
            logoutLine.leadingAnchor.constraint(equalTo: settingListView.leadingAnchor, constant: 0),
            logoutLine.trailingAnchor.constraint(equalTo: settingListView.trailingAnchor, constant: 0),
            logoutLine.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    private func addGesture() {
        deleteAccountView.tag = 1001
        inquiryView.tag = 1002
        logoutView.tag = 1003
        
        deleteAccountView.isUserInteractionEnabled = true
        inquiryView.isUserInteractionEnabled = true
        logoutView.isUserInteractionEnabled = true
        
        deleteAccountView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.viewTapped)))
        inquiryView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.viewTapped)))
        logoutView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.viewTapped)))
    }
    
    func setNotification() {
        if defaults.pushNotification {
            alarmSwitch.isOn = true
        }
        else {
            alarmSwitch.isOn = false
        }
    }
    
    @objc func onClickAlarmSwitch(sender: UISwitch) {
        if sender.isOn {
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(options: authOptions) { granted, error in
                if granted {
                    UserDefaults.standard.pushNotification = true
                    print("알림 허용")
                }
            }
            UIApplication.shared.registerForRemoteNotifications()
        }
        else {
            defaults.pushNotification = false
            UIApplication.shared.unregisterForRemoteNotifications()
        }
    }
    
    @objc func alarmBtnSelected() {
        pushNotificationVCHandler?()
    }
    
    @objc func viewTapped(sender: UITapGestureRecognizer) {
        if let tag = sender.view?.tag {
            switch tag {
            case 1001:
                tabViewHandler?(.deleteAccount)
                return
                
            case 1002:
                tabViewHandler?(.inquiry)
                return
                
            case 1003:
                tabViewHandler?(.logout)
                return
                
            default:
                return
            }
        }
    }}

extension SettingView {
    func setSettingListView() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }
    
    func setSettingListLabel(text: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .text_black
        label.textAlignment = .center
        label.text = text
        label.font = UIFont.suit(size: 18, family: .Medium)
        return label
    }
    
    func setSettingNextBtn() -> UIImageView {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(systemName: "chevron.right")
        img.tintColor = .primary
        return img
    }
    
    func setLine() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(hexString: "D9D9D9")
        return view
    }
}



