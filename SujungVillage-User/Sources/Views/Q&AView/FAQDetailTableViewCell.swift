//
//  FAQDetailTableViewCell.swift
//  SujungVillage-User
//
//  Created by 홍세은 on 2022/10/29.
//

import UIKit

class FAQDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
    }
    
    func setUI() {
        cellView.layer.borderWidth = 3
        cellView.layer.borderColor = UIColor(hexString: "FFEAAE").cgColor
        cellView.roundCorners(corners: [.topLeft, .topRight, .bottomLeft, .bottomRight], radius: 30)
        cellView.backgroundColor = .white
        cellView.addShadow(location: .bottom, opacity: 0.2, radius: 3)
        
        questionLabel.textColor = .text_gray
        questionLabel.font = UIFont.suit(size: 15, family: .Medium)
        
        answerLabel.textColor = .text_gray
        answerLabel.font = UIFont.suit(size: 12, family: .Medium)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
