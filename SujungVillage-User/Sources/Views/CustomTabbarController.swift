//
//  CustomTabbar.swift
//  SujungVillage-User
//
//  Created by 홍세은 on 2022/09/28.
//

import Foundation
import UIKit

struct TabBarItem {
    var title: String
    var icon: String
    var selectedIcon: String
}

let tabBarItems = [TabBarItem(title: "Home", icon: "home", selectedIcon: "home_selected"),
                   TabBarItem(title: "Community", icon: "community", selectedIcon: "community_selected"),
                   TabBarItem(title: "Q&A", icon: "qna", selectedIcon: "qna_selected"),
                   TabBarItem(title: "Setting", icon: "settings", selectedIcon: "settings_selected")]

class CustomTabbarController: UITabBarController {
    
    let coustmeTabBarView:UIView = {
        let view = UIView(frame: .zero)
        
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.clipsToBounds = true
        
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: -8.0)
        view.layer.shadowOpacity = 0.12
        view.layer.shadowRadius = 10.0
        return view
    }()
    
    override func viewDidLoad() {
        addcoustmeTabBarView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        for (index,tabBarItem) in tabBarItems.enumerated() {
            self.tabBar.items![index].title = tabBarItem.title
            self.tabBar.items![index].image = UIImage(named: tabBarItem.icon)
        }
        let selectedImageName = tabBarItems[0].selectedIcon
        self.tabBar.items![0].selectedImage = UIImage(named: selectedImageName)
        self.tabBar.items![0].title = ""
    }
    
    override func viewDidLayoutSubviews() {
          super.viewDidLayoutSubviews()
         coustmeTabBarView.frame = tabBar.frame
      }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        for (index,tabBarItem) in tabBarItems.enumerated() {
            self.tabBar.items![index].title = tabBarItem.title
            self.tabBar.items![index].image = UIImage(named: tabBarItem.icon)
        }
        let selectedImageName = tabBarItems.filter({$0.title == item.title})[0].selectedIcon
        item.selectedImage = UIImage(named: selectedImageName)
        item.title = ""
    }
    
    private func addcoustmeTabBarView() {
       coustmeTabBarView.frame = tabBar.frame
        view.addSubview(coustmeTabBarView)
        view.bringSubviewToFront(self.tabBar)
    }
}
