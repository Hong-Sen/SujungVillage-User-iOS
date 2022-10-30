//
//  FAQTableViewCell.swift
//  SujungVillage-User
//
//  Created by 홍세은 on 2022/10/29.
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
        cellView.roundCorners(corners: [.topLeft, .topRight, .bottomLeft, .bottomRight], radius: 30)
        cellView.layer.borderWidth = 3
        cellView.layer.borderColor = UIColor.plight.cgColor
        cellView.backgroundColor = .white
        cellView.addShadow(location: .bottom, opacity: 0.2, radius: 3)
        
        questionLabel.textColor = UIColor.text_gray
        questionLabel.font = UIFont.suit(size: 16, family: .Medium)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
