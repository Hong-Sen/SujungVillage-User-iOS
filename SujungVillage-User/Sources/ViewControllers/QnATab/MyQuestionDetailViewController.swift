//
//  MyQDetailViewController.swift
//  SujungVillage-User
//
//  Created by 홍세은 on 2022/10/30.
//

import UIKit

class MyQuestionDetailViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var questionDateLabel: UILabel!
    @IBOutlet weak var questionContentLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var removeBtn: UIButton!
    
    @IBOutlet weak var answerView: UIView!
    @IBOutlet weak var adminAnswerLabel: UILabel!
    @IBOutlet weak var answerDateLabel: UILabel!
    @IBOutlet weak var answerContentLabel: UILabel!
    var isAnswered: Bool = false
    var questionId: Int = -101
    private var viewModel = MyQuestionDetailViewModel.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchView()
        setUI()
        viewModel.fetchMyQuestionDetail(id: questionId)
    }
    
    func setUI() {
        titleLabel.font = UIFont.suit(size: 14, family: .Medium)
        titleLabel.textColor = .text_black
        
        questionDateLabel.font = UIFont.suit(size: 12, family: .Light)
        questionDateLabel.textColor = UIColor(hexString: "989898")
        nameLabel.font = UIFont.suit(size: 12, family: .Light)
        nameLabel.textColor = UIColor(hexString: "989898")
        
        removeBtn.titleLabel?.font = UIFont.suit(size: 11, family: .Regular)
        removeBtn.tintColor = UIColor(hexString: "676767")
        removeBtn.backgroundColor = UIColor(hexString: "D9D9D9")
        
        questionContentLabel.font = UIFont.suit(size: 13, family: .Light)
        questionContentLabel.textColor = .text_black
        
        if isAnswered {
            answerView.backgroundColor = UIColor(hexString: "FFF5DA")
            adminAnswerLabel.textColor = .primary
            adminAnswerLabel.font = UIFont.suit(size: 13, family: .Medium)
            answerDateLabel.textColor = UIColor(hexString: "989898")
            answerDateLabel.font = UIFont.suit(size: 10, family: .Light)
            answerContentLabel.textColor = .text_black
            answerContentLabel.font = UIFont.suit(size: 13, family: .Light)
        }
        else {
            answerView.isHidden = true
            adminAnswerLabel.isHidden = true
            answerDateLabel.isHidden = true
            answerContentLabel.isHidden = true
        }
    }
    
    func fetchView() {
        viewModel.onUpdated = {[weak self] in
            DispatchQueue.main.async {
                self?.titleLabel.text = self?.viewModel.title
                self?.questionDateLabel.text = self?.viewModel.qDate
                self?.nameLabel.text = self?.viewModel.writerName
                self?.questionContentLabel.text = self?.viewModel.questionContent
                
                self?.answerDateLabel.text = self?.viewModel.aDate
                self?.answerContentLabel.text = self?.viewModel.answerContent
            }
        }
    }
    
    @IBAction func removeBtnSelected(_ sender: Any) {
        let alert = UIAlertController(title: "삭제하시겠습니까?", message: nil, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "삭제", style: .default, handler: { UIAlertAction in
            Repository.shared.deletQuestion(questionId: self.questionId) { status, result in
                switch status {
                case .ok:
                    MyQuestionViewModel.shared.fetchMyQuestions()
                    print("삭제 성공")
                    break
                default:
                    print("remove question error: \(status)")
                    break
                }
            }
            self.navigationController?.popViewController(animated: true)
        }))
        alert.addAction(UIAlertAction(title: "취소", style: .destructive, handler: nil))
        self.present(alert, animated: true)
    }
    
    @IBAction func backBtnSelected(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
