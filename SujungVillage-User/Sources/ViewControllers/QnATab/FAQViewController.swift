//
//  FAQViewController.swift
//  SujungVillage-User
//
//  Created by 홍세은 on 2022/10/29.
//

import UIKit

class FAQViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var faqDataList: [FAQListResponse] = [
        FAQListResponse(id: 1, writerID: "1", question: "qqq11111", answer: "answer", dormitoryName: "qq", regDate: "20201010", modDate: "0330", isOpen: false),
        FAQListResponse(id: 2, writerID: "2", question: "qqq22222", answer: "answer2222", dormitoryName: "qq", regDate: "20201010", modDate: "0330", isOpen: false),
        FAQListResponse(id: 3, writerID: "3", question: "qqq33333", answer: "answer3333", dormitoryName: "qq", regDate: "20201010", modDate: "0330", isOpen: false)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "FAQDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "FAQDetailTableViewCell")
        tableView.register(UINib(nibName: "FAQTableViewCell", bundle: nil), forCellReuseIdentifier: "FAQTableViewCell")
        tableView.separatorStyle = .none
    }
    
}

extension FAQViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return faqDataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let titleCell = tableView.dequeueReusableCell(withIdentifier: "FAQTableViewCell", for: indexPath) as! FAQTableViewCell
        titleCell.questionLabel.text = faqDataList[indexPath.row].question
        titleCell.selectionStyle = .none
        return titleCell
    }
    
}
