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
    
    
    @IBOutlet weak var exeatView: UIStackView!
    @IBOutlet weak var exeatLabel: UILabel!
    @IBOutlet weak var rollCallView: UIStackView!
    @IBOutlet weak var rollCallLabel: UILabel!
    @IBOutlet weak var noticeView: UIStackView!
    @IBOutlet weak var noticeLabel: UILabel!
    @IBOutlet weak var rewardCheckView: UIStackView!
    @IBOutlet weak var rewardCheckLabel: UILabel!
    
    private let viewModel = HomeViewModel()
    var observer: NSKeyValueObservation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !UserDefaults.standard.isLogined {
            presentLoginVC()
        }
        
        observer = UserDefaults.standard.observe(\.isLogined, options: [.initial, .new], changeHandler: { (defaults, change) in
            if UserDefaults.standard.isLogined {
                self.viewModel.fetchResidentInfo(year: 2022, month: 8)
            }
        })
        
        setUI()
        fetchView()
    }
    
    func presentLoginVC() {
        guard let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController else { return }
        loginVC.modalPresentationStyle = .fullScreen
        self.present(loginVC, animated: true)
    }
    
    func setUI() {
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
        
        bottomView.roundCorners(corners: [.topLeft, .topRight], radius: 20)
        
        bottomView.layer.shadowColor = UIColor.black.cgColor
        bottomView.layer.shadowOpacity = 0.3
        bottomView.layer.shadowRadius = 3.0
        bottomView.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        
        exeatLabel.font = UIFont.suit(size: 11, family: .Medium)
        exeatLabel.textColor = UIColor(hexString: "878787")
        
        rollCallLabel.font = UIFont.suit(size: 11, family: .Medium)
        rollCallLabel.textColor = UIColor(hexString: "878787")
        
        noticeLabel.font = UIFont.suit(size: 11, family: .Medium)
        noticeLabel.textColor = UIColor(hexString: "878787")
        
        rewardCheckLabel.font = UIFont.suit(size: 11, family: .Medium)
        rewardCheckLabel.textColor = UIColor(hexString: "878787")
        
        exeatView.tag = 1000
        rollCallView.tag = 1001
        noticeView.tag = 1002
        rewardCheckView.tag = 1003
        
        exeatView.isUserInteractionEnabled = true
        rollCallView.isUserInteractionEnabled = true
        noticeView.isUserInteractionEnabled = true
        rewardCheckView.isUserInteractionEnabled = true
        
        exeatView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.viewTapped)))
        rollCallView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.viewTapped)))
        noticeView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.viewTapped)))
        rewardCheckView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.viewTapped)))
    }
    
    func fetchView() {
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
    
    @objc func viewTapped(sender: UITapGestureRecognizer) {
        if let tag = sender.view?.tag {
            switch tag {
            case 1000:
                guard let exeatVC = self.storyboard?.instantiateViewController(withIdentifier: "ApplyExeatViewController") as? ApplyExeatViewController else { return }
                exeatVC.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(exeatVC, animated: true)
                return
                
            case 1001:
                guard let rollcallVC = self.storyboard?.instantiateViewController(withIdentifier: "ApplyRollCallViewController") as? ApplyRollCallViewController else { return }
                rollcallVC.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(rollcallVC, animated: true)
                return
                
            case 1002:
                //
                return
                
            case 1003:
                guard let LMPHistoryVC = self.storyboard?.instantiateViewController(withIdentifier: "GetLmpHistoryViewController") as? GetLmpHistoryViewController else { return }
                LMPHistoryVC.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(LMPHistoryVC, animated: true)
                return
                
            default:
                return
            }
        }
    }
}
