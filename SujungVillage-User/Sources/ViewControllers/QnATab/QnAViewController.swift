//
//  QnAViewController.swift
//  SujungVillage-User
//
//  Created by 홍세은 on 2022/09/28.
//

import UIKit
import Tabman
import Pageboy

class QnAViewController: TabmanViewController {
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var navigationTitleLabel: UILabel!
    @IBOutlet weak var tabView: UIView!
    private var tabList: Array<UIViewController> = []
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setTabUI()
    }
    
    func setUI() {
        topView.backgroundColor = .primary
        topView.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 15)
        topView.addShadow(location: .bottom, opacity: 0.3, radius: 15)
        navigationTitleLabel.textColor = .white
        navigationTitleLabel.font = UIFont.suit(size: 20, family: .SemiBold)
    }
    
    func setTabUI() {
        let faqVC = self.storyboard?.instantiateViewController(withIdentifier: "FAQViewController") as! FAQViewController
        let myqVC = self.storyboard?.instantiateViewController(withIdentifier: "MyQuestionViewController") as! MyQuestionViewController
        
        tabList.append(faqVC)
        tabList.append(myqVC)
        
        self.dataSource = self
        let bar = TMBar.ButtonBar()
        
        bar.backgroundView.style = .clear
        bar.backgroundColor = .white
        bar.layout.contentMode = .fit
        bar.buttons.customize { (button) in
            button.tintColor = UIColor(hexString: "6A6A6A")
            button.selectedTintColor = .plight
            button.font = UIFont.suit(size: 16, family: .SemiBold)
            button.selectedFont =  UIFont.suit(size: 16, family: .SemiBold)
        }
        
        bar.indicator.tintColor = .plight
        addBar(bar, dataSource: self, at: .custom(view: tabView, layout: nil))
    }
    
    @IBAction func alarmBtnSelected(_ sender: Any) {
        //
    }
}

extension QnAViewController: PageboyViewControllerDataSource, TMBarDataSource {
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        switch index {
        case 0:
            return TMBarItem(title: "FAQ")
        case 1:
            return TMBarItem(title: "내 질문")
        default:
            return TMBarItem(title: "\(index)")
        }
        }
        
        func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
            return tabList.count
        }

        func viewController(for pageboyViewController: PageboyViewController,
                            at index: PageboyViewController.PageIndex) -> UIViewController? {
            return tabList[index]
        }

        func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
            return nil
        }
}
