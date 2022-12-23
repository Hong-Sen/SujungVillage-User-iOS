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
    
    override func viewDidLoad() {
        tabBar.unselectedItemTintColor = .plight
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.suit(size: 9, family: .Bold)], for: .normal)
        
        NotificationCenter.default.addObserver(self, selector: #selector(showCommunityTab(_:)), name: NSNotification.Name("showCommunityTab"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(showHomeTab(_:)), name: NSNotification.Name("showHomeTab"), object: nil)
    }
    
    @objc func showCommunityTab(_ notification:Notification) {
        self.selectedIndex = 1
        
        let selectedImageName = tabBarItems[1].selectedIcon
        self.tabBar.items![1].selectedImage = UIImage(named: selectedImageName)
        self.tabBar.items![1].title = ""
        self.tabBar.items![0].title = tabBarItems[0].title
        
    }
    
    @objc func showHomeTab(_ notification:Notification) {
        self.selectedIndex = 0
        
        let selectedImageName = tabBarItems[0].selectedIcon
        self.tabBar.items![0].selectedImage = UIImage(named: selectedImageName)
        self.tabBar.items![0].title = ""
        self.tabBar.items![3].title = tabBarItems[3].title
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
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        for (index,tabBarItem) in tabBarItems.enumerated() {
            self.tabBar.items![index].title = tabBarItem.title
            self.tabBar.items![index].image = UIImage(named: tabBarItem.icon)
        }
        
        let selectedImageName = tabBarItems.filter({$0.title == item.title})[0].selectedIcon
        item.selectedImage = UIImage(named: selectedImageName)
        item.title = ""
    }
}
