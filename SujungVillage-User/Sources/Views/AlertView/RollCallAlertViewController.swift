//
//  RollCallAlertViewController.swift
//  SujungVillage-User
//
//  Created by 홍세은 on 2022/10/20.
//

import UIKit

class RollCallAlertViewController: UIViewController {

    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var rollcallImg: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var okBtn: UIButton!
    var rollcallId: Int = -101
    var date: String = ""
    private var viewModel = GetRollCallInfoViewModel.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.rollcallId = rollcallId
        setUI()
        fetchView()
        viewModel.fetchRollCallAlert()
    }
    
    func setUI() {
        view.backgroundColor = .black.withAlphaComponent(0.42)
        alertView.layer.cornerRadius = 5
        dateLabel.font = UIFont.suit(size: 12, family: .Medium)
        dateLabel.text = "\(date) 점호"
        
        timeLabel.font = UIFont.suit(size: 11, family: .Regular)
        timeLabel.textColor = .text_black
        
        placeLabel.font = UIFont.suit(size: 11, family: .Regular)
        placeLabel.textColor = .text_black
        
        okBtn.setTitle("확인", for: .normal)
        okBtn.titleLabel?.font = UIFont.suit(size: 12, family: .Medium)
        okBtn.tintColor = .plight
    }
    
    func fetchView() {
        viewModel.onUpdated = {[weak self] in
            DispatchQueue.main.async {
                self?.rollcallImg.image = self?.viewModel.image
                self?.timeLabel.text = self?.viewModel.time
                self?.placeLabel.text = self?.viewModel.location
            }
        }
    }
    
    @IBAction func okBtnSelected(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}
