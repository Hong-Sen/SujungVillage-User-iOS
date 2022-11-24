//
//  CommunityCell.swift
//  SujungVillage-User
//
//  Created by 홍세은 on 2022/11/24.
//

import UIKit

class CommunityCell: UITableViewCell {
    
    static let cellId = "communityCell"
    
    let cellView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.roundCorners(corners: [.allCorners], radius: 10)
        view.addShadow(location: .bottom, opacity: 0.1, radius: 1)
        return view
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .text_black
        label.textAlignment = .left
        return label
    }()
    
     var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = UIColor(hexString: "A5A5A5")
        label.textAlignment = .right
        return label
    }()
    
     var contentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textColor = UIColor(hexString: "6A6A6A")
        label.textAlignment = .left
        label.numberOfLines = 2
        return label
    }()
    
    private var commentImg: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "icon_comment")
        return img
    }()
    
    
     var numOfCommentsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor(hexString: "A5A5A5")
        label.textAlignment = .center
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor(hexString: "FBFBFB")
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    }
    
    func setUpViews() {
        setUpCellView()
        setUpTitleLabel()
        setUpDateLabel()
        setUpContentLabel()
        setUpNumberOfCommentLabel()
        setUpCommentImg()
    }
    
    private func setUpCellView() {
        self.addSubview(cellView)
        NSLayoutConstraint.activate([
            cellView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            cellView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            cellView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            cellView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
    private func setUpTitleLabel() {
        cellView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 18),
            titleLabel.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -78)
        ])
    }
    
    private func setUpDateLabel() {
        cellView.addSubview(dateLabel)
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 21),
            dateLabel.rightAnchor.constraint(equalTo: cellView.rightAnchor, constant: -10)
        ])
    }
    
    private func setUpContentLabel() {
        cellView.addSubview(contentLabel)
        NSLayoutConstraint.activate([
            contentLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 13),
            contentLabel.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 20),
            contentLabel.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -21)
        ])
    }
    
    private func setUpNumberOfCommentLabel() {
        cellView.addSubview(numOfCommentsLabel)
        NSLayoutConstraint.activate([
            numOfCommentsLabel.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -10),
            numOfCommentsLabel.rightAnchor.constraint(equalTo: cellView.rightAnchor, constant: -19)
        ])
    }
    
    private func setUpCommentImg() {
        cellView.addSubview(commentImg)
        NSLayoutConstraint.activate([
            commentImg.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -13),
            commentImg.trailingAnchor.constraint(equalTo: numOfCommentsLabel.leadingAnchor, constant: -3)
        ])
    }
}
