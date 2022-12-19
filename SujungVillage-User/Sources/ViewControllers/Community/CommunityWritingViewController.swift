//
//  CommunityWritingViewController.swift
//  SujungVillage-User
//
//  Created by 홍세은 on 2022/11/27.
//

import UIKit
import DropDown

class CommunityWritingViewController: UIViewController {

    @IBOutlet weak var chooseBoardLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var boardView: UIView!
    @IBOutlet weak var boardLabel: UILabel!
    @IBOutlet weak var dropdownBtn: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var registerBtn: UIButton!
    let dropdown = DropDown()
    private var isdropdownBtnClicked: Bool = false
    let menuList = ["전체", "성미료", "성미관", "엠시티", "그레이스", "이율", "운정빌", "장수", "풍림"] 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setDropDown()
        hideKeyboard()
    }
    
    func setUI() {
        chooseBoardLabel.font = UIFont.suit(size: 16, family: .Regular)
        chooseBoardLabel.textColor = .text_black
        
        titleLabel.font = UIFont.suit(size: 16, family: .Regular)
        titleLabel.textColor = .text_black
        
        boardLabel.font = UIFont.suit(size: 16, family: .Regular)
        boardLabel.textColor = .primary
        
        boardView.isUserInteractionEnabled = true
        boardView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.boardViewSelected)))
        
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.primary.cgColor
        contentView.roundCorners(corners: [.allCorners], radius: 15)
        
        contentTextView.font = UIFont.suit(size: 16, family: .Regular)
        boardLabel.textColor = .text_black
        
        registerBtn.titleLabel?.font = UIFont.suit(size: 18, family: .Bold)
        registerBtn.titleLabel?.textColor = .white
        registerBtn.tintColor = .primary
        registerBtn.layer.masksToBounds = true
        registerBtn.layer.cornerRadius = registerBtn.frame.size.height/2
    }

    @IBAction func backBtnSelected(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func registerBtnSelected(_ sender: Any) {
        if let title = titleTextField.text, let content = contentTextView.text {
            if title.count == 0 {
                let alert = UIAlertController(title: "제목을 입력해주세요", message: nil, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))
                self.present(alert, animated: true)
                return
            }
            if content.count == 0 {
                let alert = UIAlertController(title: "내용을 입력해주세요", message: nil, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))
                self.present(alert, animated: true)
                return
            }
                            
            let writePostModel = CommunityWritePostModel(title: title, content: content)
            Repository.shared.writePost(writeModel: writePostModel) { status, response in
                switch status {
                case .ok:
                    self.navigationController?.popViewController(animated: true)
                default:
                    print("register posting error: \(status)")
                }
            }
        }
    }
    
    @objc func boardViewSelected() {
        isdropdownBtnClicked = !isdropdownBtnClicked
        dropdown.show()
    }
}

extension CommunityWritingViewController {
    func setDropDown() {
        dropdown.dataSource = menuList
        dropdown.anchorView = self.boardView
        dropdown.bottomOffset = CGPoint(x: 0, y: boardView.bounds.height)
        dropdown.selectionAction = { [weak self] (index, item) in
            self!.boardLabel.text = item
            self!.boardLabel.textColor = .primary
            self!.isdropdownBtnClicked = !self!.isdropdownBtnClicked
            self!.dropdownBtn.image = self!.isdropdownBtnClicked ? UIImage(systemName: "chevron.up") : UIImage(systemName: "chevron.down")
        }
        
        dropdown.cancelAction = { [weak self] in
            self!.isdropdownBtnClicked = !self!.isdropdownBtnClicked
            self!.dropdownBtn.image = self!.isdropdownBtnClicked ? UIImage(systemName: "chevron.up") : UIImage(systemName: "chevron.down")
        }
    }
}
