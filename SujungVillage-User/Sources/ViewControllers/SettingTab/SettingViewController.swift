//
//  SettingViewController.swift
//  SujungVillage-User
//
//  Created by 홍세은 on 2022/09/28.
//

import UIKit

class SettingViewController: UIViewController {
    let infoView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 15)
        view.addShadow(location: .bottom, opacity: 0.15, radius: 15)
        return view
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .text_black
        label.textAlignment = .center
        label.text = "000"
        label.font = UIFont.suit(size: 20, family: .SemiBold)
        return label
    }()
    
    let identityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .text_gray
        label.textAlignment = .center
        label.text = "재사생"
        label.font = UIFont.suit(size: 14, family: .Medium)
        return label
    }()
    
    let dormitoryImg: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "icon_dormitory")
        return img
    }()
    
    let dormitoryInfoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .text_gray
        label.textAlignment = .center
        label.text = "000"
        label.font = UIFont.suit(size: 14, family: .Medium)
        return label
    }()
    
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let settingListView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    var alarmLine = UIView()
    var alarmSettingLabel = UILabel()
    let alarmSwitch: UISwitch = {
        let swt = UISwitch()
        swt.translatesAutoresizingMaskIntoConstraints = false
        swt.onTintColor = .primary
        return swt
    }()
    
    var potalLine = UIView()
    var potalView = UIView()
    var potalLabel = UILabel()
    var potalNextImg = UIImageView()
    
    var howToUseLine = UIView()
    var howToUseView = UIView()
    var howToUseLabel = UILabel()
    var howToUseNextImg = UIImageView()
    
    var inquiryLine = UIView()
    var inquiryView = UIView()
    var inquiryLabel = UILabel()
    var inquiryNextImg = UIImageView()
    
    var logoutLine = UIView()
    var logoutView = UIView()
    var logoutLabel = UILabel()
    var logoutNextImg = UIImageView()
    
    private let viewModel = UserInfoViewModel.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchView()
        setUI()
        viewModel.fetchResidentInfo(year: Calendar.current.component(.year, from: Date()), month: Calendar.current.component(.month, from: Date()))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchView()
        setUI()
        viewModel.fetchResidentInfo(year: Calendar.current.component(.year, from: Date()), month: Calendar.current.component(.month, from: Date()))
    }
    
    func setUI() {
        self.navigationController?.navigationBar.barStyle = .default
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.topItem?.title = "설정"
        
        let alarmItem = UIBarButtonItem(image: UIImage(named: "icon_bell_black"),
                                        style: .plain,
                                        target: self,
                                        action: #selector(alarmBtnSelected))
        self.navigationItem.rightBarButtonItem = alarmItem
        self.navigationItem.rightBarButtonItem?.tintColor = .black
        
        self.view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        scrollView.addSubview(settingListView)
        
        NSLayoutConstraint.activate([
            settingListView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            settingListView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            settingListView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            settingListView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor)
        ])
        
        self.settingListView.addSubview(infoView)
        
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
        
        settingListView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        let settingListViewHeight = settingListView.heightAnchor.constraint(greaterThanOrEqualTo: self.view.heightAnchor)
        settingListViewHeight.priority = .defaultLow
        settingListViewHeight.isActive = true
        
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
        
        potalView = setSettingListView()
        settingListView.addSubview(potalView)
        NSLayoutConstraint.activate([
            potalView.topAnchor.constraint(equalTo: alarmLine.bottomAnchor, constant: 0),
            potalView.leftAnchor.constraint(equalTo: settingListView.leftAnchor, constant: 0),
            potalView.rightAnchor.constraint(equalTo: settingListView.rightAnchor, constant: 0),
            potalView.heightAnchor.constraint(equalToConstant: 84)
        ])
        
        potalLabel = setSettingListLabel(text: "성신 포탈")
        potalView.addSubview(potalLabel)
        
        NSLayoutConstraint.activate([
            potalLabel.centerYAnchor.constraint(equalTo: potalView.centerYAnchor),
            potalLabel.leftAnchor.constraint(equalTo: potalView.leftAnchor, constant: 40)
        ])
        
        potalNextImg = setSettingNextBtn()
        potalView.addSubview(potalNextImg)
        
        NSLayoutConstraint.activate([
            potalNextImg.widthAnchor.constraint(equalToConstant: 22),
            potalNextImg.heightAnchor.constraint(equalToConstant: 22),
            potalNextImg.centerYAnchor.constraint(equalTo: potalView.centerYAnchor),
            potalNextImg.trailingAnchor.constraint(equalTo: potalView.trailingAnchor, constant: -40)
        ])
        
        potalLine = setLine()
        settingListView.addSubview(potalLine)
        NSLayoutConstraint.activate([
            potalLine.topAnchor.constraint(equalTo: potalView.bottomAnchor, constant: 0),
            potalLine.leadingAnchor.constraint(equalTo: settingListView.leadingAnchor, constant: 0),
            potalLine.trailingAnchor.constraint(equalTo: settingListView.trailingAnchor, constant: 0),
            potalLine.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        howToUseView = setSettingListView()
        settingListView.addSubview(howToUseView)
        NSLayoutConstraint.activate([
            howToUseView.topAnchor.constraint(equalTo: alarmLine.bottomAnchor, constant: 0),
            howToUseView.leftAnchor.constraint(equalTo: settingListView.leftAnchor, constant: 0),
            howToUseView.rightAnchor.constraint(equalTo: settingListView.rightAnchor, constant: 0),
            howToUseView.heightAnchor.constraint(equalToConstant: 84)
        ])
        
        howToUseLabel = setSettingListLabel(text: "앱 사용법")
        howToUseView.addSubview(howToUseLabel)
        
        NSLayoutConstraint.activate([
            howToUseLabel.centerYAnchor.constraint(equalTo: howToUseView.centerYAnchor),
            howToUseLabel.leftAnchor.constraint(equalTo: howToUseView.leftAnchor, constant: 40)
        ])
        
        howToUseNextImg = setSettingNextBtn()
        howToUseView.addSubview(howToUseNextImg)
        
        NSLayoutConstraint.activate([
            howToUseNextImg.widthAnchor.constraint(equalToConstant: 22),
            howToUseNextImg.heightAnchor.constraint(equalToConstant: 22),
            howToUseNextImg.centerYAnchor.constraint(equalTo: howToUseView.centerYAnchor),
            howToUseNextImg.trailingAnchor.constraint(equalTo: howToUseView.trailingAnchor, constant: -40)
        ])
        
        howToUseLine = setLine()
        settingListView.addSubview(howToUseLine)
        NSLayoutConstraint.activate([
            howToUseLine.topAnchor.constraint(equalTo: howToUseView.bottomAnchor, constant: 0),
            howToUseLine.leadingAnchor.constraint(equalTo: settingListView.leadingAnchor, constant: 0),
            howToUseLine.trailingAnchor.constraint(equalTo: settingListView.trailingAnchor, constant: 0),
            howToUseLine.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        inquiryView = setSettingListView()
        settingListView.addSubview(inquiryView)
        NSLayoutConstraint.activate([
            inquiryView.topAnchor.constraint(equalTo: potalLine.bottomAnchor, constant: 0),
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
        
        potalView.tag = 1000
        howToUseView.tag = 1001
        inquiryView.tag = 1002
        logoutView.tag = 1003
        
        potalView.isUserInteractionEnabled = true
        howToUseView.isUserInteractionEnabled = true
        inquiryView.isUserInteractionEnabled = true
        logoutView.isUserInteractionEnabled = true
        
        potalView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.viewTapped)))
        howToUseView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.viewTapped)))
        inquiryView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.viewTapped)))
        logoutView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.viewTapped)))
    }
    
    func fetchView() {
        viewModel.onUpdated = {[weak self] in
            DispatchQueue.main.async { [self] in
                self?.nameLabel.text = self?.viewModel.userName
                if let dormitory = self?.viewModel.dormitoryName,
                   let detailedAddress = self?.viewModel.detailedAddress {
                    self?.dormitoryInfoLabel.text = "\(dormitory) | \(detailedAddress)"
                }
            }
        }
    }
    
    
    @objc func alarmBtnSelected() {
        let notificationVC = NotificationViewController()
        self.navigationController?.pushViewController(notificationVC, animated: true)
    }
    
    @objc func viewTapped(sender: UITapGestureRecognizer) {
        if let tag = sender.view?.tag {
            switch tag {
            case 1000:
                //
                return
                
            case 1001:
                //
                return
                
            case 1002:
                //
                return
                
            case 1003:
                let alert = UIAlertController(title: "로그아웃 하시겠습니까?", message: nil, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "확인", style: .default, handler: { UIAlertAction in
                    UserDefaults.standard.autoLogin = false
                    UserDefaults.standard.needLogin = true
                    self.tabBarController?.selectedIndex = 0
                }))
                alert.addAction(UIAlertAction(title: "취소", style: .destructive, handler: nil))
                present(alert, animated: true)
                return
                
            default:
                return
            }
        }
    }
}

extension SettingViewController {
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


