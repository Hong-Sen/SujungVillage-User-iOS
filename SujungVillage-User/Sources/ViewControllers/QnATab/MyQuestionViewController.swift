//
//  MyQuestionViewController.swift
//  SujungVillage-User
//
//  Created by 홍세은 on 2022/10/29.
//

import UIKit

class MyQuestionViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    private let viewModel = MyQuestionViewModel.shared
    var myQuestionList: [MyQTitleResponse] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchTableView()
        setTableView()
        viewModel.fetchMyQuestions()
    }
    
    func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        let nibName = UINib(nibName: "MyQCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "MyQCell")
        tableView.separatorStyle = .none
    }
    
    func fetchTableView() {
        viewModel.onUpdated = {[weak self] in
            DispatchQueue.main.async {
                self?.myQuestionList = self?.viewModel.myQList ?? []
                self?.tableView.reloadData()
            }
        }
    }
    
}

extension MyQuestionViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myQuestionList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyQCell", for: indexPath) as! MyQCell
        let isAnswered = myQuestionList[indexPath.row].answered
        cell.questionLabel.text = myQuestionList[indexPath.row].title
        cell.isAnsweredLabel.text = isAnswered ? "답변완료" : "미답변"
        cell.isAnsweredLabel.layer.backgroundColor = isAnswered ? UIColor.pdark.cgColor : UIColor.text_gray.cgColor
        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let myQDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "MyQuestionDetailViewController") as? MyQuestionDetailViewController else { return }
        myQDetailVC.isAnswered = myQuestionList[indexPath.row].answered
        myQDetailVC.questionId = myQuestionList[indexPath.row].questionID
        self.navigationController?.pushViewController(myQDetailVC, animated: true)
    }
}
