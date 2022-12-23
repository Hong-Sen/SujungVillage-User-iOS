//
//  AppNotificationView.swift
//  SujungVillage-User
//
//  Created by 홍세은 on 2022/12/13.
//

import UIKit

class AppNotificationView: UIView {

    lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private lazy var emptyView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    var appNotiList: [NotificationResponse] = []
    
    init() {
        super.init(frame: .zero)
        setTable()
        setupEmptyView()
        setupTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupEmptyView() {
        addSubview(emptyView)
        NSLayoutConstraint.activate([
            emptyView.topAnchor.constraint(equalTo: topAnchor),
            emptyView.leadingAnchor.constraint(equalTo: leadingAnchor),
            emptyView.trailingAnchor.constraint(equalTo: trailingAnchor),
            emptyView.heightAnchor.constraint(equalToConstant: 130)])
}
    
    private func setupTableView() {
        addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: emptyView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)])
    }
}

extension AppNotificationView: UITableViewDelegate, UITableViewDataSource {
    func setTable() {
        tableView.register(NotificationCell.classForCoder(), forCellReuseIdentifier: NotificationCell.cellId)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.bounces = true
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appNotiList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NotificationCell.cellId, for: indexPath) as! NotificationCell
        
        cell.typeLabel.text = appNotiList[indexPath.row].type
        cell.contentLabel.text = appNotiList[indexPath.row].content
        cell.dateLabel.text = appNotiList[indexPath.row].regDate
        
        cell.separatorInset = UIEdgeInsets.zero
        cell.selectionStyle = .none
        return cell
    }
}
