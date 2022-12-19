//
//  NotificationViewController.swift
//  SujungVillage-User
//
//  Created by 홍세은 on 2022/12/13.
//

import UIKit
import Tabman
import Pageboy

class NotificationViewController: TabmanViewController {
    
    private lazy var tabmanView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private let notificationView = NotificationMainView()
    private var tabList: Array<UIViewController> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setAction()
        setupTabman()
        setupTabmanView()
    }
    
    private func setupView() {
        self.navigationController?.isNavigationBarHidden = true
        self.view.addSubview(notificationView)
        notificationView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            notificationView.topAnchor.constraint(equalTo: self.view.topAnchor),
            notificationView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            notificationView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            notificationView.heightAnchor.constraint(equalToConstant: 90)
        ])
    }
    
    private func setupTabmanView() {
        self.view.addSubview(tabmanView)
        NSLayoutConstraint.activate([
            tabmanView.topAnchor.constraint(equalTo:notificationView.bottomAnchor),
            tabmanView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tabmanView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            tabmanView.heightAnchor.constraint(equalToConstant: 46)
        ])
    }
    
    private func setAction() {
        notificationView.setupPopVCHandler {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    private func setupTabman() {
        let appNotiVC = AppNotificationViewController()
        let communityNotiVC = CommunityNotificationViewController()
        tabList.append(appNotiVC)
        tabList.append(communityNotiVC)
        
        self.dataSource = self
        let bar = TMBar.ButtonBar()
        
        bar.backgroundView.style = .clear
        bar.backgroundColor = .white
        bar.layout.contentMode = .fit
        bar.buttons.customize { btn in
            btn.tintColor = .text_black
            btn.selectedTintColor = .primary
            btn.font = UIFont.suit(size: 16, family: .SemiBold)
            btn.selectedFont =  UIFont.suit(size: 16, family: .SemiBold)
        }
        bar.indicator.tintColor = .primary
        bar.addShadow(location: .bottom, opacity: 0.1, radius: 3)
        addBar(bar, dataSource: self, at: .custom(view: self.tabmanView, layout: nil))
    }
}

extension NotificationViewController: PageboyViewControllerDataSource, TMBarDataSource {
    func numberOfViewControllers(in pageboyViewController: Pageboy.PageboyViewController) -> Int {
        return tabList.count
    }
    
    func viewController(for pageboyViewController: Pageboy.PageboyViewController, at index: Pageboy.PageboyViewController.PageIndex) -> UIViewController? {
        return tabList[index]
    }
    
    func defaultPage(for pageboyViewController: Pageboy.PageboyViewController) -> Pageboy.PageboyViewController.Page? {
        return nil
    }
    
    func barItem(for bar: Tabman.TMBar, at index: Int) -> Tabman.TMBarItemable {
        switch index {
        case 0:
            return TMBarItem(title: "앱 알림")
        case 1:
            return TMBarItem(title: "커뮤니티 알림")
        default:
            return TMBarItem(title: "\(index)")
        }
    }
}
