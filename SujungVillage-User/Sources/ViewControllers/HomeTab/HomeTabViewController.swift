//
//  HomeTabViewController.swift
//  SujungVillage-User
//
//  Created by 홍세은 on 2022/09/28.
//

import UIKit

class HomeTabViewController: UIViewController {
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var alarmBtn: UIBarButtonItem!
    @IBOutlet weak var backgroundImg: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var dormitoryLabel: UILabel!
    @IBOutlet weak var rewardPointLabel: UILabel!
    @IBOutlet weak var bottomView: UIView!

    
    @IBOutlet weak var overnightLabel: UILabel!
    @IBOutlet weak var rollCallLabel: UILabel!
    @IBOutlet weak var noticeLabel: UILabel!
    @IBOutlet weak var rewardCheckLabel: UILabel!
    
    private let viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDefaultView()
        setView()
    }
    
    func setDefaultView() {
        self.view?.backgroundColor = UIColor(hexString: "FFA114")
        
        backgroundImg.image = UIImage(named: "home_background")
        backgroundImg.contentMode = .scaleToFill
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        navigationBar.standardAppearance = appearance
        
        navigationBar.tintColor = .white
        alarmBtn.image = UIImage(systemName: "bell")
        
        nameLabel.font = UIFont.suit(size: 34, family: .Bold)
        nameLabel.textColor = .white

        welcomeLabel.font = UIFont.suit(size: 22, family: .Bold)
        welcomeLabel.textColor = .white
        welcomeLabel.text = "님 반갑습니다!"
        
        dormitoryLabel.font = UIFont.suit(size: 14, family: .Medium)
        dormitoryLabel.textColor = UIColor(hexString: "FFEEBD")
        
        rewardPointLabel.font = UIFont.suit(size: 14, family: .Medium)
        rewardPointLabel.textColor = UIColor(hexString: "FFEEBD")
        
        bottomView.roundTopCorners()

        bottomView.layer.shadowColor = UIColor.black.cgColor
        bottomView.layer.shadowOpacity = 0.3
        bottomView.layer.shadowRadius = 3.0
        bottomView.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        
        overnightLabel.font = UIFont.suit(size: 11, family: .Medium)
        overnightLabel.textColor = UIColor(hexString: "878787")
        
        rollCallLabel.font = UIFont.suit(size: 11, family: .Medium)
        rollCallLabel.textColor = UIColor(hexString: "878787")
        
        noticeLabel.font = UIFont.suit(size: 11, family: .Medium)
        noticeLabel.textColor = UIColor(hexString: "878787")
        
        rewardCheckLabel.font = UIFont.suit(size: 11, family: .Medium)
        rewardCheckLabel.textColor = UIColor(hexString: "878787")
    
    }
    
    func setView() {
        viewModel.onUpdated = {[weak self] in
            DispatchQueue.main.async {
                self?.nameLabel.text = self?.viewModel.userName
                if let dormitory = self?.viewModel.dormitoryName {
                    self?.dormitoryLabel.text = "\(dormitory) 기숙사"
                }
                if let plus = self?.viewModel.plusLMP, let minus = self?.viewModel.minusLMP {
                    self?.rewardPointLabel.text = "상점 : \(plus)점    |    벌점 : \(minus)점"
                }
            }
        }
    }
}

extension UIView {

   func roundTopCorners(radius: CGFloat = 30) {
       self.clipsToBounds = true
       self.layer.cornerRadius = radius
       if #available(iOS 11.0, *) {
           self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
       } else {
           self.roundCorners(corners: [.topLeft, .topRight], radius: radius)
       }
   }

   private func roundCorners(corners: UIRectCorner, radius: CGFloat) {    
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
