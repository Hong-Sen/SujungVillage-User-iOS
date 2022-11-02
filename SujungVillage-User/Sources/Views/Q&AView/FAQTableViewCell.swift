//
//  FAQTableViewCell.swift
//  SujungVillage-User
//
//  Created by 홍세은 on 2022/11/01.
//

import UIKit

class FAQTableViewCell: UITableViewCell {

    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var arrowImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
    }
    
    func setUI() {
        cellView.layer.borderWidth = 3
        cellView.layer.borderColor = UIColor(hexString: "FFEAAE").cgColor
        cellView.roundCorners(corners: [.allCorners], radius: 30)
        cellView.backgroundColor = .white
        cellView.addShadow(location: .bottom, opacity: 0.2, radius: 3)
        cellView.frame.size.height = 97
        
        questionLabel.textColor = UIColor.text_gray
        questionLabel.font = UIFont.suit(size: 15, family: .Medium)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
