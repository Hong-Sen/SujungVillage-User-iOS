//
//  WriteQuestionViewController.swift
//  SujungVillage-User
//
//  Created by 홍세은 on 2022/11/02.
//

import UIKit

class WriteQuestionViewController: UIViewController {

    @IBOutlet weak var anonymousLabel: UILabel!
    @IBOutlet weak var anonymousBtn: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var registerBtn: UIButton!
    private var isAnonymous: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    func setUI() {
        anonymousLabel.textColor = UIColor(hexString: "111111")
        anonymousLabel.font = UIFont.suit(size: 16, family: .Regular)
        
        titleLabel.textColor = UIColor(hexString: "111111")
        titleLabel.font = UIFont.suit(size: 16, family: .Regular)
        
        anonymousBtn.tintColor = .primary
        anonymousBtn.setImage(UIImage(systemName: "square"), for: .normal)
        
        titleTextField.textColor = .text_black
        titleTextField.font = UIFont.suit(size: 15, family: .Light)
        
        contentView.roundCorners(corners: [.allCorners], radius: 15)
        contentView.layer.borderColor = UIColor.primary.cgColor
        contentView.layer.borderWidth = 1
        
        contentTextView.delegate = self
        contentTextView.textColor = .placeholderText
        contentTextView.font = UIFont.suit(size: 15, family: .Light)
        contentTextView.text = "내용을 입력하세요."
        
        registerBtn.titleLabel?.font = UIFont.suit(size: 18, family: .Bold)
        registerBtn.titleLabel?.textColor = .white
        registerBtn.tintColor = .primary
        registerBtn.layer.masksToBounds = true
        registerBtn.layer.cornerRadius = registerBtn.frame.size.height/2
    }

    @IBAction func anonymousBtnSelected(_ sender: Any) {
        isAnonymous = !isAnonymous
        anonymousBtn.setImage(isAnonymous ? UIImage(systemName: "checkmark.square.fill") : UIImage(systemName: "square"), for: .normal)
    }
    
    @IBAction func backBtnSelected(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func registerBtnSelected(_ sender: Any) {
        if titleTextField.text == "" {
            let alert = UIAlertController(title: "제목을 입력해주세요.", message: nil, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
            present(alert, animated: true)
            return
        }
        if contentTextView.text == "내용을 입력하세요." ||  contentTextView.text ==  "" {
            let alert = UIAlertController(title: "내용을 입력해주세요.", message: nil, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
            present(alert, animated: true)
            return
        }
        if let title = titleTextField.text,
           let content = contentTextView.text {
            let writeModel = WriteQuestionModel(title: title , content: content, anonymous: isAnonymous)
            Repository.shared.writeQuestion(writeModel: writeModel) { status, response in
                switch status {
                case .ok:
                    print("write question 성공")
                    self.navigationController?.popViewController(animated: true)
                    break
                default:
                    print("write question error: \(status)")
                }
            }
        }
    }
}

extension WriteQuestionViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .placeholderText {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "내용을 입력하세요."
            textView.textColor = .placeholderText
        }
    }
}
