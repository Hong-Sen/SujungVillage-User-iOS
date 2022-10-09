//
//  LMPHistoryTableViewCell.swift
//  SujungVillage-User
//
//  Created by 홍세은 on 2022/10/08.
//

import UIKit

class LMPHistoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var scoreView: UIView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var reasonView: UIView!
    @IBOutlet weak var reasonLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        dateView.layer.borderColor = UIColor(hexString: "FFB800").cgColor
        dateView.layer.borderWidth = 1
        scoreView.layer.borderColor = UIColor(hexString: "FFB800").cgColor
        scoreView.layer.borderWidth = 1
        reasonView.layer.borderColor = UIColor(hexString: "FFB800").cgColor
        reasonView.layer.borderWidth = 1
        
        dateLabel.font = UIFont.suit(size: 12, family: .Regular)
        dateLabel.textColor = UIColor.text_black
        
        scoreLabel.font = UIFont.suit(size: 12, family: .Regular)
        scoreLabel.textColor = UIColor.text_black
        
        reasonLabel.font = UIFont.suit(size: 12, family: .Regular)
        reasonLabel.textColor = UIColor.text_black
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
