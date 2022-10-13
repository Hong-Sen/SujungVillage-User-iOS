//
//  NoticeTableViewCell.swift
//  SujungVillage-User
//
//  Created by 홍세은 on 2022/10/12.
//

import UIKit

class NoticeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var noticeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
    }
    
    func setUI() {
        noticeLabel.text = "공지"
        noticeLabel.textColor = .white
        noticeLabel.font = UIFont.suit(size: 12, family: .SemiBold)
        noticeLabel.layer.backgroundColor = UIColor.pdark.cgColor
        noticeLabel.layer.masksToBounds = true
        noticeLabel.layer.cornerRadius = noticeLabel.frame.size.height/2
        
        titleLabel.font = UIFont.suit(size: 11, family: .Medium)
        titleLabel.textColor = UIColor(hexString: "111111")
        
        dateLabel.font = UIFont.suit(size: 12, family: .Regular)
        dateLabel.textColor = UIColor(hexString: "878787")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
