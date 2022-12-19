//
//  NotificationCell.swift
//  SujungVillage-User
//
//  Created by 홍세은 on 2022/12/16.
//

import UIKit

class NotificationCell: UITableViewCell {
    static let cellId = "NotificationCell"
    
    var cellView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    var typeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = UIColor(hexString: "5C5C5C")
        label.textAlignment = .left
        return label
    }()
    
    var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = UIColor(hexString: "ABABAB")
        label.textAlignment = .right
        return label
    }()
    
    var contentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = UIColor(hexString: "5C5C5C")
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
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
    
    func setUpViews() {
        setUpCellView()
        setUpTypeLabel()
        setUpContentLabel()
        setUpDateLabel()
    }
    
    private func setUpCellView() {
        self.addSubview(cellView)
        NSLayoutConstraint.activate([
            cellView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            cellView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            cellView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            cellView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0)
        ])
    }
    
    private func setUpTypeLabel() {
        cellView.addSubview(typeLabel)
        NSLayoutConstraint.activate([
            typeLabel.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 46),
            typeLabel.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: UIScreen.main.bounds.width * 0.134),
            typeLabel.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -UIScreen.main.bounds.width * 0.134)
        ])
    }
    
    private func setUpContentLabel() {
        cellView.addSubview(contentLabel)
        NSLayoutConstraint.activate([
            contentLabel.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: 1),
            contentLabel.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: UIScreen.main.bounds.width * 0.134),
            contentLabel.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -UIScreen.main.bounds.width * 0.134),
            contentLabel.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -46)
        ])
    }
    
    private func setUpDateLabel() {
        cellView.addSubview(dateLabel)
        NSLayoutConstraint.activate([
            dateLabel.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -16),
            dateLabel.rightAnchor.constraint(equalTo: cellView.rightAnchor, constant: -29)
        ])
    }
}
