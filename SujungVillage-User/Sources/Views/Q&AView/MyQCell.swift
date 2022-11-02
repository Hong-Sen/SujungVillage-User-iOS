//
//  MyQCell.swift
//  SujungVillage-User
//
//  Created by 홍세은 on 2022/10/30.
//

import UIKit

class MyQCell: UITableViewCell {

    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var isAnsweredLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
    }
    
    func setUI() {
        cellView.roundCorners(corners: [.allCorners], radius: 30)
        cellView.layer.borderWidth = 3
        cellView.layer.borderColor = UIColor(hexString: "FFEAAE").cgColor
        cellView.backgroundColor = .white
        cellView.addShadow(location: .bottom, opacity: 0.2, radius: 3)
        
        isAnsweredLabel.font = UIFont.suit(size: 12, family: .Medium)
        isAnsweredLabel.textColor = .white
        isAnsweredLabel.layer.masksToBounds = true
        isAnsweredLabel.layer.cornerRadius = isAnsweredLabel.frame.size.height/2
        
        questionLabel.textColor = UIColor.text_gray
        questionLabel.font = UIFont.suit(size: 15, family: .Medium)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
