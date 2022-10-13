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
