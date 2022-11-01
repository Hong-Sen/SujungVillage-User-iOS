//
//  FAQViewController.swift
//  SujungVillage-User
//
//  Created by 홍세은 on 2022/10/29.
//

import UIKit

class FAQViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private let viewModel = FAQViewModel.shared
    var faqDataList: [FAQListResponse] = []
    var selectIdx = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchTableView()
        setTableView()
        viewModel.fetchFAQs()
    }
    
    func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "FAQDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "FAQDetailTableViewCell")
        tableView.register(UINib(nibName: "FAQTableViewCell", bundle: nil), forCellReuseIdentifier: "FAQTableViewCell")
        tableView.separatorStyle = .none
    }
    
    func fetchTableView() {
        viewModel.onUpdated = {[weak self] in
            DispatchQueue.main.async {
                self?.faqDataList = self?.viewModel.FAQList ?? []
                self?.tableView.reloadData()
            }
        }
    }
}

extension FAQViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == selectIdx {
            return CGFloat(180 + (faqDataList[indexPath.row].answer.count / 44) * 20)
        }
        else {
            return 97
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return faqDataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == selectIdx {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FAQDetailTableViewCell", for: indexPath) as! FAQDetailTableViewCell
            cell.questionLabel.text = faqDataList[indexPath.row].question
            cell.answerLabel.text = faqDataList[indexPath.row].answer
            return cell
        }
        else {
            let titleCell = tableView.dequeueReusableCell(withIdentifier: "FAQTableViewCell", for: indexPath) as! FAQTableViewCell
            titleCell.questionLabel.text = faqDataList[indexPath.row].question
            titleCell.selectionStyle = .none
            return titleCell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if selectIdx == indexPath.row {
            selectIdx = -1
        }
        else {
            selectIdx = indexPath.row
        }
        self.tableView.reloadData()
    }
}
