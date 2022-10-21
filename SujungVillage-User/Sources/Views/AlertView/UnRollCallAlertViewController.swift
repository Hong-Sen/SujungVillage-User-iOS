//
//  UnRollCallAlertViewController.swift
//  SujungVillage-User
//
//  Created by 홍세은 on 2022/10/20.
//

import UIKit

class UnRollCallAlertViewController: UIViewController {

    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var failLabel: UILabel!
    @IBOutlet weak var okBtn: UIButton!
    var date: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }

    func setUI() {
        view.backgroundColor = .black.withAlphaComponent(0.42)
        alertView.layer.cornerRadius = 5
        dateLabel.font = UIFont.suit(size: 13, family: .Medium)
        dateLabel.text = "\(date) 점호"
        
        failLabel.text = "해당 점호에 참여하지 않았어요." 
        failLabel.font = UIFont.suit(size: 11, family: .Regular)
        failLabel.textColor = .text_black
        
        okBtn.setTitle("확인", for: .normal)
        okBtn.titleLabel?.font = UIFont.suit(size: 12, family: .Medium)
        okBtn.tintColor = UIColor(hexString: "FF7979")
        
    }
    
    @IBAction func okBtnSelected(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
