//
//  MyQuestionViewController.swift
//  SujungVillage-User
//
//  Created by 홍세은 on 2022/10/29.
//

import UIKit
import DTZFloatingActionButton

class MyQuestionViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private let viewModel = MyQuestionViewModel.shared
    var myQuestionList: [MyQTitleResponse] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchTableView()
        createWritingBtn()
        setTableView()
        viewModel.fetchMyQuestions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchTableView()
        viewModel.fetchMyQuestions()
    }
    
    func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        let nibName = UINib(nibName: "MyQCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "MyQCell")
        tableView.backgroundColor = .clear
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
    
    private func createWritingBtn() {
        let writingBtn = DTZFloatingActionButton(frame:CGRect(x: view.frame.size.width - 56 - 16, y: view.frame.size.height - 56 - 16 - 130, width: 56, height: 56))
        writingBtn.handler = {
            button in
            self.presentWritingView()
        }
        writingBtn.isScrollView = true
        writingBtn.buttonImage = UIImage(named: "icon_pencil")
        writingBtn.shadowCircleColor = .black
        writingBtn.shadowCircleOffSet = CGSize(width: 0, height: 2)
        writingBtn.shadowCircleOpacity = 0.2
        writingBtn.shadowCircleRadius = 2
        writingBtn.isAddShadow = true
        writingBtn.buttonColor = .primary
        self.view.addSubview(writingBtn)
    }
    
    private func presentWritingView() {
        guard let writeVC = self.storyboard?.instantiateViewController(withIdentifier: "WriteQuestionViewController") as? WriteQuestionViewController else { return }
        self.navigationController?.pushViewController(writeVC, animated: true)
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
