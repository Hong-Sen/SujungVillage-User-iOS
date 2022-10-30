//
//  GetNoticeViewController.swift
//  SujungVillage-User
//
//  Created by 홍세은 on 2022/10/12.
//

import UIKit

class GetNoticeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private let viewModel = NoticeViewModel.shared
    var noticeList: [NoticeTitleResponse] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchTableView()
        setTableView()
        viewModel.fetchNoticeTitle()
    }
    
    func setTableView() {
        let nibName = UINib(nibName: "NoticeTableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "noticeTableViewCell")
    }
    
    func fetchTableView() {
        viewModel.onUpdated = {[weak self] in
            DispatchQueue.main.async {
                self?.noticeList = self?.viewModel.noticeTitleList ?? []
                self?.tableView.reloadData()
            }
        }
    }
    
    @IBAction func backBtnSelected(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension GetNoticeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 73
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noticeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noticeTableViewCell", for: indexPath) as! NoticeTableViewCell
        
        var date = noticeList[indexPath.row].regDate
        let endIdx = date.index(date.startIndex, offsetBy: 9)
        date = String(date[...endIdx]).replacingOccurrences(of: "-", with: ".")
        
        cell.titleLabel.text = noticeList[indexPath.row].title
        cell.dateLabel.text = date
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let noticeDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "GetNoticeDetailViewController") as? GetNoticeDetailViewController else { return }
        noticeDetailVC.announcementId = noticeList[indexPath.row].id
        self.navigationController?.pushViewController(noticeDetailVC, animated: true)
    }
}
