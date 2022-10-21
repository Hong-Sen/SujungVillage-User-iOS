//
//  NoticeDetailViewController.swift
//  SujungVillage-User
//
//  Created by 홍세은 on 2022/10/13.
//

import UIKit

class GetNoticeDetailViewController: UIViewController {

    @IBOutlet weak var dormitoryNameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: PaddingLabel!
    var announcementId: Int = 0
    private var viewModel = NoticeDetailViewModel.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.announcementId = announcementId
        setUI()
        fetchView()
        viewModel.fetchNoticeDetail()
    }
    
    func setUI() {
        dormitoryNameLabel.textColor = .primary
        dormitoryNameLabel.font = UIFont.suit(size: 14, family: .Regular)
        
        titleLabel.textColor = .black
        titleLabel.font = UIFont.suit(size: 14, family: .Regular)
        
        contentLabel.textColor = .black
        contentLabel.font = UIFont.suit(size: 12, family: .Light)
        contentLabel.layer.borderWidth = 1
        contentLabel.layer.cornerRadius = 15
        contentLabel.layer.borderColor = UIColor.primary.cgColor
    }
    
    func fetchView() {
        viewModel.onUpdated = {[weak self] in
            DispatchQueue.main.async {
                self?.dormitoryNameLabel.text = self?.viewModel.dormitoryName
                self?.titleLabel.text = self?.viewModel.title
                self?.contentLabel.text = self?.viewModel.content
            }
        }
    }
    
    @IBAction func backBtnSelected(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
