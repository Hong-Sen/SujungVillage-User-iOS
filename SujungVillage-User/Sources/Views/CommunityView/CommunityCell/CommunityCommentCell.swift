//
//  CommunityCommentCell.swift
//  SujungVillage-User
//
//  Created by 홍세은 on 2022/12/03.
//

import UIKit

class CommunityCommentCell: UITableViewCell {
    
    static let identifier = "commentCell"
    var height = 0
    
    private lazy var cellView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .text_black
        return label
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 11, weight: .light)
        label.textColor = .text_gray
        return label
    }()
    
    lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .light)
        label.textColor = .text_black
        label.numberOfLines = 0
        return label
    }()
    
    lazy var deleteBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.tintColor = .text_gray
        btn.setTitle("댓글삭제", for: .normal)
        btn.setTitleColor(.text_gray, for: .normal)
        btn.titleLabel?.font = UIFont.suit(size: 10, family: .Light)
        return btn
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    }
    
    private func setUpViews() {
        setUpCellView()
        setUpNameLabel()
        setUpDeleteBtn()
        setUpDateLabel()
        setUpContentLabel()
    }
    
    private func setUpCellView() {
        addSubview(cellView)
        NSLayoutConstraint.activate([
            cellView.topAnchor.constraint(equalTo: topAnchor),
            cellView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cellView.trailingAnchor.constraint(equalTo: trailingAnchor),
            cellView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setUpNameLabel() {
        cellView.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 42)
        ])
    }
    
    private func setUpDeleteBtn() {
        cellView.addSubview(deleteBtn)
        NSLayoutConstraint.activate([
            deleteBtn.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 13),
            deleteBtn.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -34)
        ])
    }
    
    private func setUpDateLabel() {
        cellView.addSubview(dateLabel)
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 3),
            dateLabel.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 42)
        ])
    }
    
    private func setUpContentLabel() {
        cellView.addSubview(contentLabel)
        NSLayoutConstraint.activate([
            contentLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 7),
            contentLabel.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 42),
            contentLabel.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -40)
        ])
    }
}
