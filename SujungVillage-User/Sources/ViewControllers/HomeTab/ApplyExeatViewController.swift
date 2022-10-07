//
//  ApplyExeatViewController.swift
//  SujungVillage-User
//
//  Created by 홍세은 on 2022/10/07.
//

import UIKit
import DropDown

class ApplyExeatViewController: UIViewController {
    
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var typeTextField: UITextField!
    @IBOutlet weak var dropView: UIView!
    @IBOutlet weak var dropDownBtn: UIButton!
    @IBOutlet weak var periodLabel: UILabel!
    @IBOutlet weak var periodStartTextField: UITextField!
    @IBOutlet weak var periodEndTextField: UITextField!
    @IBOutlet weak var destinationLabel: UILabel!
    @IBOutlet weak var destinationTextField: UITextField!
    @IBOutlet weak var resonLabel: UILabel!
    @IBOutlet weak var resonTextField: UITextField!
    @IBOutlet weak var emergencyNumberTextField: UITextField!
    @IBOutlet weak var emergencyNumberLabel: UILabel!
    @IBOutlet weak var rememberLabel: UILabel!
    @IBOutlet weak var rememberBtn: UIButton!
    @IBOutlet weak var applyBtn: UIButton!
    private var rememberInfo: Bool = false
    let dropdown = DropDown()
    private var isdropdownBtnClicked: Bool = false
    let menuList = ["단기 외박","장기 외박"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setDropDown()
    }
    
    func setUI() {
        typeLabel.font = UIFont.suit(size: 16, family: .SemiBold)
        typeLabel.textColor = UIColor.text_black
        
        periodLabel.font = UIFont.suit(size: 16, family: .SemiBold)
        periodLabel.textColor = UIColor.text_black
        
        destinationLabel.font = UIFont.suit(size: 16, family: .SemiBold)
        destinationLabel.textColor = UIColor.text_black
        
        resonLabel.font = UIFont.suit(size: 16, family: .SemiBold)
        resonLabel.textColor = UIColor.text_black
        
        emergencyNumberLabel.font = UIFont.suit(size: 16, family: .SemiBold)
        emergencyNumberLabel.textColor = UIColor.text_black
        
        rememberLabel.font = UIFont.suit(size: 14, family: .Medium)
        rememberLabel.textColor = UIColor.primary
        rememberBtn.tintColor = UIColor.primary
        
        applyBtn.titleLabel?.font = UIFont.suit(size: 18, family: .Bold)
        applyBtn.setTitleColor(.white, for: .normal)
        applyBtn.tintColor = .primary
    }
    @IBAction func backBtnSelected(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func typeBtnSelected(_ sender: Any) {
//        dropDownBtn.setImage(UIImage(systemName: "arrowtriangle.down.fill"), for: .normal)
                isdropdownBtnClicked = !isdropdownBtnClicked
                dropDownBtn.setImage(isdropdownBtnClicked ? UIImage(systemName: "arrowtriangle.up.fill") : UIImage(systemName: "arrowtriangle.down.fill"), for: .normal)
        dropdown.show()
    }
    
    @IBAction func periodStartBtnSelected(_ sender: Any) {
        popDatePicker(textField: periodStartTextField)
    }
    
    @IBAction func periodEndBtnSelected(_ sender: Any) {
        popDatePicker(textField: periodEndTextField)
    }
    
    @IBAction func rememberBtnSelected(_ sender: Any) {
        rememberInfo = !rememberInfo
        rememberBtn.setImage(rememberInfo ? UIImage(systemName: "checkmark.square") : UIImage(systemName: "square"), for: .normal)
    }
    
    @IBAction func applyBtnSelected(_ sender: Any) {
        if let destination = destinationTextField.text,
           let reson = resonTextField.text,
           let emergencyNum = emergencyNumberTextField.text,
           let dateToStart = periodStartTextField.text,
           let dateToEnd = periodEndTextField.text {
            let model = ApplyExeatModel(destination: destination, reason: reson, emergencyPhoneNumber: emergencyNum, dateToStart: dateToStart, dateToEnd: dateToEnd)
            Repository.shared.applyExeat(applyModel: model) { status in
                switch status {
                case .ok:
                    print("외박신청 제출 완료")
                default:
                    print("error: \(status)")
                    break
                }
            }
        }
        self.navigationController?.popViewController(animated: true)
    }
}

extension ApplyExeatViewController {
    func setDropDown() {
        dropdown.dataSource = menuList
        dropdown.anchorView = self.dropView
        dropdown.bottomOffset = CGPoint(x: 0, y: dropView.bounds.height)
        dropdown.selectionAction = { [weak self] (index, item) in
            self!.typeTextField.text = item
            self!.isdropdownBtnClicked = !self!.isdropdownBtnClicked
            self!.dropDownBtn.setImage(self!.isdropdownBtnClicked ? UIImage(systemName: "arrowtriangle.up.fill") : UIImage(systemName: "arrowtriangle.down.fill"), for: .normal)
        }
        
        dropdown.cancelAction = { [weak self] in
            self!.isdropdownBtnClicked = !self!.isdropdownBtnClicked
            self!.dropDownBtn.setImage(self!.isdropdownBtnClicked ? UIImage(systemName: "arrowtriangle.up.fill") : UIImage(systemName: "arrowtriangle.down.fill"), for: .normal)
        }
    }
}

extension ApplyExeatViewController {
    func popDatePicker(textField: UITextField) {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.locale = NSLocale(localeIdentifier: "ko_KO") as Locale
        
        let dateChooserAlert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        dateChooserAlert.view.addSubview(datePicker)
        dateChooserAlert.addAction(UIAlertAction(title: "선택 완료", style: .cancel, handler: { UIAlertAction in
            self.donePick(datePicker: datePicker, textField: textField)
        }))
        
        let height : NSLayoutConstraint = NSLayoutConstraint(item: dateChooserAlert.view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 300)
        dateChooserAlert.view.addConstraint(height)
        
        present(dateChooserAlert, animated: true, completion: nil)
    }
    
    func donePick(datePicker: UIDatePicker, textField: UITextField){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        textField.text = dateFormatter.string(from: datePicker.date)
    }
}
