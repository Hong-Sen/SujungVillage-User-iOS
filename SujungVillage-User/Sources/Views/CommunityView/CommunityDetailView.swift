//
//  CommunityDetailView.swift
//  SujungVillage-User
//
//  Created by 홍세은 on 2022/12/03.
//

import UIKit

class CommunityDetailView: UIView {
    
    private lazy var navigationBar : UINavigationBar = {
        let navigationBar = UINavigationBar()
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithTransparentBackground()
        navigationBar.tintColor = .black
        navigationBar.scrollEdgeAppearance = navigationBarAppearance
        navigationBar.standardAppearance = navigationBarAppearance
        navigationBar.backgroundColor = .white
        return navigationBar
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemPink
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .text_black
        label.font = UIFont.suit(size: 16, family: .Medium)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(hexString: "989898")
        label.font = UIFont.suit(size: 12, family: .Light)
        return label
    }()
    
    lazy var contentLable: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .text_black
        label.font = UIFont.suit(size: 15, family: .Light)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var commentImg: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "icon_comment_color")
        img.tintColor = .primary
        return img
    }()
    
    lazy var commentCtnLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .primary
        label.font = UIFont.suit(size: 13, family: .Regular)
        return label
    }()
    
    lazy var deleteBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.tintColor = .text_gray
        btn.setTitle("삭제하기", for: .normal)
        btn.setTitleColor(.text_gray, for: .normal)
        btn.titleLabel?.font = UIFont.suit(size: 11, family: .Regular)
        return btn
    }()
    
    private lazy var lineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(hexString: "D9D9D9")
        return view
    }()
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .white
        return table
    }()
    
    lazy var commentList: [CommunityComment] = []
    var popVCHandler: (() -> Void)?
    
    init() {
        super.init(frame: .zero)
        setTableView()
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupPopVCHandler(_ handler: @escaping() -> Void) {
        popVCHandler = handler
    }
    
    private func setTableView() {
        tableView.register(CommunityCommentCell.classForCoder(), forCellReuseIdentifier: CommunityCommentCell.identifier)
//        tableView.rowHeight = UITableView.automaticDimension
//        tableView.estimatedRowHeight = 150
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupViews() {
        self.backgroundColor = .white
        setupNaviBar()
        setupContentView()
        setupTitleLabel()
        setupDateLabel()
        setupContentLabel()
        setupCommentImg()
        setupCommentCntLabel()
        setupDeleteBtn()
        setupLineView()
        setupCommentView()
    }
    
    private func setupNaviBar() {
        addSubview(navigationBar)
        let safeArea = self.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: safeArea.topAnchor),
            navigationBar.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
        ])
        
        let navItem = UINavigationItem(title: "게시판")
        let leftBtn = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backBtnSelected))
        navItem.leftBarButtonItem = leftBtn
        navigationBar.setItems([navItem], animated: true)
    }
    
    private func setupContentView() {
        addSubview(contentView)
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: topAnchor, constant: 100),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    private func setupTitleLabel() {
        contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 19),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 39),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -39)
        ])
    }
    
    private func setupDateLabel() {
        contentView.addSubview(dateLabel)
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40)
        ])
    }
    
    private func setupContentLabel() {
        contentView.addSubview(contentLable)
        NSLayoutConstraint.activate([
            contentLable.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 19),
            contentLable.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            contentLable.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40)
        ])
    }
    
    private func setupCommentImg() {
        contentView.addSubview(commentImg)
        NSLayoutConstraint.activate([
            commentImg.topAnchor.constraint(equalTo: contentLable.bottomAnchor, constant: 36),
            commentImg.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40)
        ])
    }
    
    private func setupCommentCntLabel() {
        contentView.addSubview(commentCtnLabel)
        NSLayoutConstraint.activate([
            commentCtnLabel.topAnchor.constraint(equalTo: contentLable.bottomAnchor, constant: 33),
            commentCtnLabel.leadingAnchor.constraint(equalTo: commentImg.trailingAnchor, constant: 5)
        ])
    }
    
    private func setupDeleteBtn() {
        contentView.addSubview(deleteBtn)
        NSLayoutConstraint.activate([
            deleteBtn.topAnchor.constraint(equalTo: contentLable.bottomAnchor, constant: 34),
            deleteBtn.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -34)
        ])
    }
    
    private func setupLineView() {
        addSubview(lineView)
        NSLayoutConstraint.activate([
            lineView.topAnchor.constraint(equalTo: deleteBtn.bottomAnchor, constant: 9),
            lineView.trailingAnchor.constraint(equalTo: trailingAnchor),
            lineView.leadingAnchor.constraint(equalTo: leadingAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    private func setupCommentView() {
        addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: lineView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    @objc func backBtnSelected() {
        popVCHandler?()
    }
    
}

extension CommunityDetailView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 80
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CommunityCommentCell.identifier, for: indexPath) as! CommunityCommentCell
        cell.nameLabel.text = "익명\(indexPath.row + 1)"
        var formatTime = commentList[indexPath.row].modDate.replacingOccurrences(of: "T", with: " ")
        formatTime = formatTime.replacingOccurrences(of: "-", with: "/")
        cell.dateLabel.text = String(formatTime.prefix(16))
        cell.contentLabel.text = commentList[indexPath.row].content
        if commentList[indexPath.row].writerID != UserDefaults.standard.string(forKey: "id") {
            cell.deleteBtn.isEnabled = true
            cell.deleteBtn.setTitle("", for: .normal)
        }
        cell.separatorInset = UIEdgeInsets.zero
        cell.selectionStyle = .none
        return cell
    }
    
}
