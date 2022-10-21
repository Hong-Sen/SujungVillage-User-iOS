//
//  ExeatAlertViewController.swift
//  SujungVillage-User
//
//  Created by 홍세은 on 2022/10/20.
//

import UIKit

class ExeatAlertViewController: UIViewController {

    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var userPlaceLabel: UILabel!
    @IBOutlet weak var reasonLabel: UILabel!
    @IBOutlet weak var userReasonLabel: UILabel!
    @IBOutlet weak var emergencyPhoneNumberLabel: UILabel!
    @IBOutlet weak var userEmergencyPhoneNumberLabel: UILabel!
    @IBOutlet weak var cancleBtn: UIButton!
    @IBOutlet weak var okBtn: UIButton!
    var date: String = ""
    var exeatId: Int = -101
    private var viewModel = GetExeatInfoViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Date: \(date)")
        viewModel.exeatId = exeatId
        viewModel.fetchExeatAlert()
        setUI()
        fetchView()
    }
    
    func setUI() {
        view.backgroundColor = .black.withAlphaComponent(0.42)
        alertView.layer.cornerRadius = 5
        dateLabel.font = UIFont.suit(size: 13, family: .Medium)
        dateLabel.text = "\(date) 외박"
        
        placeLabel.text = " •  행선지 :"
        placeLabel.font = UIFont.suit(size: 11, family: .Regular)
        placeLabel.textColor = .text_black
        
        userPlaceLabel.font = UIFont.suit(size: 11, family: .Regular)
        userPlaceLabel.textColor = .text_black
        
        reasonLabel.text = " •  사유 :"
        reasonLabel.font = UIFont.suit(size: 11, family: .Regular)
        reasonLabel.textColor = .text_black
        
        userReasonLabel.font = UIFont.suit(size: 11, family: .Regular)
        userReasonLabel.textColor = .text_black
        
        emergencyPhoneNumberLabel.text = " •  긴급 전화번호 :"
        emergencyPhoneNumberLabel.font = UIFont.suit(size: 11, family: .Regular)
        emergencyPhoneNumberLabel.textColor = .text_black
        
        userEmergencyPhoneNumberLabel.font = UIFont.suit(size: 11, family: .Regular)
        userEmergencyPhoneNumberLabel.textColor = .text_black
        
        cancleBtn.setTitle("외박 취소", for: .normal)
        cancleBtn.tintColor = .primary
        cancleBtn.titleLabel?.font = UIFont.suit(size: 12, family: .Medium)
        
        okBtn.setTitle("확인", for: .normal)
        okBtn.tintColor = .white
        okBtn.titleLabel?.font = UIFont.suit(size: 12, family: .Medium)
        okBtn.backgroundColor = .primary
        okBtn.layer.cornerRadius = 8
        
    }


    func fetchView() {
        viewModel.onUpdated = {[weak self] in
            DispatchQueue.main.async {
                self?.userPlaceLabel.text = self?.viewModel.destination
                self?.userReasonLabel.text = self?.viewModel.reason
                self?.userEmergencyPhoneNumberLabel.text = self?.viewModel.emergencyPhoneNumber
            }
        }
    }
    
    @IBAction func cancleBtnSelected(_ sender: Any) {
        Repository.shared.cancleExeat(exeatId: exeatId) { status, result in
            switch status {
            case .ok:
                if result == "외박신청 취소 완료" {
                    let alert = UIAlertController(title: "외박신청 취소 완료", message: nil, preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "확인", style: .cancel, handler: { UIAlertAction in
                        self.dismiss(animated: true)
                    }))
                    self.present(alert, animated: true)
                }
                else {
                    let alert = UIAlertController(title: "외박신청 취소 실패", message: nil, preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "확인", style: .cancel, handler: { UIAlertAction in
                        self.dismiss(animated: true)
                    }))
                    self.present(alert, animated: true)
                }
            default:
                print("cancle exeat error: \(status)")
                break
            }
        }
    }
    
    
    @IBAction func okBtnSelected(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}
