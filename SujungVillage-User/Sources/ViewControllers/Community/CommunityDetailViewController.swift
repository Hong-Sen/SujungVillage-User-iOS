//
//  CommunityDetailViewController.swift
//  SujungVillage-User
//
//  Created by 홍세은 on 2022/12/03.
//

import UIKit

class CommunityDetailViewController: UIViewController {
    private lazy var detailView = CommunityDetailView()
    private lazy var commentCell = CommunityCommentCell()
    var dormitoryName: String = "게시판"
    var postId: Int = -1
    private let viewModel = CommunityDetailViewModel.shared
    var commentList: [CommunityComment] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchView()
        setupViews()
        setAction()
        viewModel.fetchCommunityDetail(postId: postId)
        hideKeyboard()
        
        NotificationCenter.default.addObserver(self, selector: #selector(CommunityDetailViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(CommunityDetailViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func fetchView() {
        viewModel.onUpdated = {[weak self] in
            DispatchQueue.main.async { [self] in
                if UserDefaults.standard.string(forKey: "id") != self?.viewModel.writerId {
                    self?.detailView.deleteBtn.isEnabled = true
                    self?.detailView.deleteBtn.setTitle("", for: .normal)
                }
                self?.detailView.postId = self?.postId ?? -1
                self?.detailView.dormitoryLabel.text = self?.dormitoryName
                self?.detailView.titleLabel.text = self?.viewModel.title
                self?.detailView.dateLabel.text = self?.viewModel.date
                self?.detailView.contentLable.text = self?.viewModel.content
                self?.commentList = self?.viewModel.commentList ?? []
                self?.detailView.commentList = self?.commentList ?? []
                self?.detailView.tableView.reloadData()
                if let commentCnt = self?.commentList.count {
                    self?.detailView.commentCtnLabel.text = "\(commentCnt)"
                }
            }
        }
    }
    
    
    private func setupViews() {
        view.addSubview(detailView)
        detailView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            detailView.topAnchor.constraint(equalTo: view.topAnchor),
            detailView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            detailView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            detailView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setAction() {
        detailView.setupPopVCHandler {
            self.navigationController?.popViewController(animated: true)
        }
        
        detailView.setupRegisterCommentHandler {
            if let comment = self.detailView.commentTextField.text {
                if comment.count == 0 { return }
                let commentModel = WriteCommentModel(postId: self.postId, content: comment)
                CommunityManager.shared.addComment(commentModel: commentModel) { result in
                    if !result { return }
                    self.detailView.commentTextField.text = ""
                    self.viewModel.fetchCommunityDetail(postId: self.postId)
                    self.fetchView()
                    self.detailView.tableView.reloadData()
                }
            }
        }
        
        detailView.setupDeletePostHandler {
            let alert = UIAlertController(title: "게시물을 삭제하시겠습니까?", message: nil, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "삭제", style: .cancel, handler: { UIAlertAction in
                Repository.shared.deleteCommunityPost(postId: self.postId) { status, result in
                    if result == "게시물 삭제 완료" {
                        self.navigationController?.popViewController(animated: true)
                    }
                    else {
                        print("게시물 삭제 실패:\(status)")
                    }
                }
            }))
            alert.addAction(UIAlertAction(title: "취소", style: .destructive, handler: nil))
            self.present(alert, animated: true)
        }
        
        detailView.setupDeleteCommentHandler() {
            let commentId = UserDefaults.standard.integer(forKey: "deleteCommentId")
            CommunityManager.shared.deleteComment(commentId: commentId) { result in
                if !result { return }
                self.viewModel.fetchCommunityDetail(postId: self.postId)
                self.fetchView()
                self.detailView.tableView.reloadData()
            }
        }
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        self.view.frame.origin.y = 90 - keyboardSize.height
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
    }
}
