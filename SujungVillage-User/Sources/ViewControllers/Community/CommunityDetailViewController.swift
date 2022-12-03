//
//  CommunityDetailViewController.swift
//  SujungVillage-User
//
//  Created by 홍세은 on 2022/12/03.
//

import UIKit

class CommunityDetailViewController: UIViewController {
    private lazy var detailView = CommunityDetailView()
    var postId: Int = -1
    private let viewModel = CommunityDetailViewModel.shared
    var commentList: [CommunityComment] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchView()
        setupViews()
        setAction()
        viewModel.fetchCommunityDetail(postId: postId)
    }
    
    func fetchView() {
        viewModel.onUpdated = {[weak self] in
            DispatchQueue.main.async { [self] in
                self?.detailView.titleLabel.text = self?.viewModel.title
                self?.detailView.dateLabel.text = self?.viewModel.date
                self?.detailView.contentLable.text = self?.viewModel.content
                self?.commentList = self?.viewModel.commentList ?? []
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
    }
    
}
