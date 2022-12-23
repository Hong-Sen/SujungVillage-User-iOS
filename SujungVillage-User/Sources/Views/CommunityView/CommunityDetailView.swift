//
//  CommunityDetailView.swift
//  SujungVillage-User
//
//  Created by 홍세은 on 2022/12/03.
//

import UIKit

class CommunityDetailView: UIView {
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = .white
        return scrollView
    }()
    
    private lazy var allView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var navigationBarView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var backBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        btn.tintColor = .black
        btn.addTarget(self, action: #selector(backBtnSelected), for: .touchUpInside)
        return btn
    }()
    
    lazy var dormitoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .text_black
        label.font = UIFont.suit(size: 22, family: .SemiBold)
        label.text = "게시판"
        return label
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
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("삭제하기", for: .normal)
        btn.setTitleColor(.text_gray, for: .normal)
        btn.titleLabel?.font = UIFont.suit(size: 14, family: .Light)
        btn.addTarget(self, action: #selector(deletePost), for: .touchUpInside)
        return btn
    }()
    
    
    private lazy var lineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(hexString: "D9D9D9")
        return view
    }()
    
    lazy var tableView: DynamicHeightTableView = {
        let table = DynamicHeightTableView()
        table.isDynamicSizeRequired = true
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .white
        return table
    }()
    
    private lazy var writeCommentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.primary.cgColor
        view.roundCorners(corners: [.allCorners], radius: 5)
        view.backgroundColor = UIColor(hexString: "FFF5DA")
        return view
    }()
    
    lazy var commentTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "댓글을 입력하세요."
        tf.font = UIFont.suit(size: 17, family: .Regular)
        tf.setPadding(left: 10, right: 10)
        return tf
    }()
    
    private lazy var bottomView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var registerCommentBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("  등록  ", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.suit(size: 14, family: .SemiBold)
        btn.roundCorners(corners: [.allCorners], radius: 5)
        btn.backgroundColor = .primary
        btn.addTarget(self, action: #selector(registerComment), for: .touchUpInside)
        return btn
    }()
    
    lazy var commentList: [CommunityComment] = []
    var popVCHandler: (() -> Void)?
    var registerCommentHandler: (() -> Void)?
    var deletePostHandler: (() -> Void)?
    var deleteCommentHandler: (()->Void)?
    var postId: Int = -1
    
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
    
    func setupRegisterCommentHandler(_ handler: @escaping() -> Void) {
        registerCommentHandler = handler
    }
    
    func setupDeletePostHandler(_ handler: @escaping() -> Void) {
        deletePostHandler = handler
    }
    
    func setupDeleteCommentHandler(_ handler: @escaping() -> Void) {
        deleteCommentHandler = handler
    }
    
    private func setTableView() {
        tableView.register(CommunityCommentCell.classForCoder(), forCellReuseIdentifier: CommunityCommentCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = false
    }
    
    private func setupViews() {
        self.backgroundColor = .white
        setupScrollView()
        setupAllView()
        setupNaviBar()
        setupBackBtn()
        setupDormitoryLabel()
        setupTitleLabel()
        setupDateLabel()
        setupContentLabel()
        setupCommentImg()
        setupCommentCntLabel()
        setupDeleteBtn()
        setupLineView()
        setupCommentView()
        setupBottomView()
        setupRegisterBtn()
        setupWriteCommentView()
        setupCommentTextField()
    }
    
    private func setupScrollView() {
        addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -80)
        ])
    }
    
    private func setupAllView() {
        scrollView.addSubview(allView)
        NSLayoutConstraint.activate([
            allView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            allView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            allView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            allView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
        
        let contentViewCenterY = allView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor)
        contentViewCenterY.priority = .defaultLow
        
        let contentViewHeight = allView.heightAnchor.constraint(greaterThanOrEqualTo: self.heightAnchor)
        contentViewHeight.priority = .defaultLow
        
        NSLayoutConstraint.activate([
            allView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            contentViewCenterY,
            contentViewHeight
        ])
    }
    
    private func setupNaviBar() {
        allView.addSubview(navigationBarView)
        NSLayoutConstraint.activate([
            navigationBarView.topAnchor.constraint(equalTo: allView.topAnchor, constant: 0),
            navigationBarView.leadingAnchor.constraint(equalTo: allView.leadingAnchor, constant: 0),
            navigationBarView.trailingAnchor.constraint(equalTo: allView.trailingAnchor, constant: 0),
            navigationBarView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupBackBtn() {
        navigationBarView.addSubview(backBtn)
        NSLayoutConstraint.activate([
            backBtn.bottomAnchor.constraint(equalTo: navigationBarView.bottomAnchor, constant: -10),
            backBtn.leadingAnchor.constraint(equalTo: navigationBarView.leadingAnchor, constant: 15)
        ])
    }
    
    private func setupDormitoryLabel() {
        navigationBarView.addSubview(dormitoryLabel)
        NSLayoutConstraint.activate([
            dormitoryLabel.bottomAnchor.constraint(equalTo: navigationBarView.bottomAnchor, constant: -10),
            dormitoryLabel.centerXAnchor.constraint(equalTo: navigationBarView.centerXAnchor)
        ])
    }
    
    private func setupTitleLabel() {
        allView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: navigationBarView.bottomAnchor, constant: 19),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 39),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -39)
        ])
    }
    
    private func setupDateLabel() {
        allView.addSubview(dateLabel)
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            dateLabel.leadingAnchor.constraint(equalTo: allView.leadingAnchor, constant: 40)
        ])
    }
    
    private func setupContentLabel() {
        allView.addSubview(contentLable)
        NSLayoutConstraint.activate([
            contentLable.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 19),
            contentLable.leadingAnchor.constraint(equalTo: allView.leadingAnchor, constant: 40),
            contentLable.trailingAnchor.constraint(equalTo: allView.trailingAnchor, constant: -40)
        ])
    }
    
    private func setupCommentImg() {
        allView.addSubview(commentImg)
        NSLayoutConstraint.activate([
            commentImg.topAnchor.constraint(equalTo: contentLable.bottomAnchor, constant: 36),
            commentImg.leadingAnchor.constraint(equalTo: allView.leadingAnchor, constant: 40)
        ])
    }
    
    private func setupCommentCntLabel() {
        allView.addSubview(commentCtnLabel)
        NSLayoutConstraint.activate([
            commentCtnLabel.topAnchor.constraint(equalTo: contentLable.bottomAnchor, constant: 33),
            commentCtnLabel.leadingAnchor.constraint(equalTo: commentImg.trailingAnchor, constant: 5)
        ])
    }
    
    private func setupDeleteBtn() {
        allView.addSubview(deleteBtn)
        NSLayoutConstraint.activate([
            deleteBtn.topAnchor.constraint(equalTo: contentLable.bottomAnchor, constant: 34),
            deleteBtn.trailingAnchor.constraint(equalTo: allView.trailingAnchor, constant: -34)
        ])
    }
    
    private func setupLineView() {
        allView.addSubview(lineView)
        NSLayoutConstraint.activate([
            lineView.topAnchor.constraint(equalTo: deleteBtn.bottomAnchor, constant: 9),
            lineView.trailingAnchor.constraint(equalTo: trailingAnchor),
            lineView.leadingAnchor.constraint(equalTo: leadingAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    private func setupCommentView() {
        allView.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: lineView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: allView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: allView.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: allView.bottomAnchor)
        ])
    }
    
    func setupBottomView() {
        addSubview(bottomView)
        NSLayoutConstraint.activate([
            bottomView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0),
            bottomView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomView.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    private func setupWriteCommentView() {
        bottomView.addSubview(writeCommentView)
        NSLayoutConstraint.activate([
            writeCommentView.topAnchor.constraint(equalTo: bottomView.topAnchor),
            writeCommentView.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 25),
            writeCommentView.trailingAnchor.constraint(equalTo: registerCommentBtn.leadingAnchor, constant: -10),
            writeCommentView.heightAnchor.constraint(equalToConstant: 37)
        ])
    }
    
    private func setupCommentTextField() {
        writeCommentView.addSubview(commentTextField)
        NSLayoutConstraint.activate([
            commentTextField.centerYAnchor.constraint(equalTo: writeCommentView.centerYAnchor),
            commentTextField.leadingAnchor.constraint(equalTo: writeCommentView.leadingAnchor, constant: 5),
            commentTextField.trailingAnchor.constraint(equalTo: writeCommentView.trailingAnchor, constant: -5)
            
        ])
    }
    
    private func setupRegisterBtn() {
        bottomView.addSubview(registerCommentBtn)
        NSLayoutConstraint.activate([
            registerCommentBtn.topAnchor.constraint(equalTo: bottomView.topAnchor),
            registerCommentBtn.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -25),
            registerCommentBtn.heightAnchor.constraint(equalToConstant: 37)
            
        ])
    }
    
    @objc func backBtnSelected() {
        popVCHandler?()
    }
    
    @objc func registerComment() {
        registerCommentHandler?()
    }
    
    @objc func deletePost() {
        deletePostHandler?()
    }
    
    @objc func deleteBtnSelected(_ sender: UIButton) {
        UserDefaults.standard.set(sender.tag, forKey: "deleteCommentId")
        deleteCommentHandler?()
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
        cell.commentId = commentList[indexPath.row].id
        cell.nameLabel.text = "익명\(indexPath.row + 1)"
        var formatTime = commentList[indexPath.row].modDate.replacingOccurrences(of: "T", with: " ")
        formatTime = formatTime.replacingOccurrences(of: "-", with: "/")
        cell.dateLabel.text = String(formatTime.prefix(16))
        cell.contentLabel.text = commentList[indexPath.row].content
        if commentList[indexPath.row].writerID != UserDefaults.standard.string(forKey: "id") {
            cell.deleteBtn.isEnabled = true
            cell.deleteBtn.setTitle("", for: .normal)
        }
        cell.deleteBtn.tag = commentList[indexPath.row].id
        cell.deleteBtn.addTarget(self, action: #selector(deleteBtnSelected), for: .touchUpInside)
        cell.separatorInset = UIEdgeInsets.zero
        cell.selectionStyle = .none
        return cell
    }
}


class DynamicHeightTableView: UITableView {
    var isDynamicSizeRequired = false
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if bounds.size != self.intrinsicContentSize {
            if self.intrinsicContentSize.height > frame.size.height {
                self.invalidateIntrinsicContentSize()
            }
        }
        
        if isDynamicSizeRequired {
            self.invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return contentSize
    }
    
}
