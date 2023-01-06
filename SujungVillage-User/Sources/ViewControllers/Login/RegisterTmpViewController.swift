////
////  RegisterTmpViewController.swift
////  SujungVillage-User
////
////  Created by 홍세은 on 2023/01/06.
////
//
//import UIKit
//import DropDown
//import Alamofire
//import CryptoSwift
//
//class RegisterTmpViewController: UIViewController {
//        @IBOutlet weak var idLabel: UILabel!
//        @IBOutlet weak var idInputTextField: UITextField!
//        @IBOutlet weak var checkOverlapIdBtn: UIButton!
//        @IBOutlet weak var resultOverlapIdLabel: UILabel!
//        @IBOutlet weak var pwdLabel: UILabel!
//        @IBOutlet weak var pwdInputTextField: UITextField!
//        @IBOutlet weak var checkPwdLabel: UILabel!
//        @IBOutlet weak var checkPwdTextField: UITextField!
//        @IBOutlet weak var resultCheckPwdLabel: UILabel!
//        @IBOutlet weak var nameLabel: UILabel!
//        @IBOutlet weak var nameTextField: UITextField!
//        @IBOutlet weak var phoneNumberLabel: UILabel!
//        @IBOutlet weak var pn1TextField: UITextField!
//        @IBOutlet weak var pn2TextField: UITextField!
//        @IBOutlet weak var pn3TextField: UITextField!
//        @IBOutlet weak var dormitoryLabel: UILabel!
//        @IBOutlet weak var dormitoryDropView: UIView!
//        @IBOutlet weak var dormitoryTextField: UITextField!
//        @IBOutlet weak var dormitoryDropDownBtn: UIButton!
//        @IBOutlet weak var roomLabel: UILabel!
//        @IBOutlet weak var roomTextField: UITextField!
//        @IBOutlet weak var registerBtn: UIButton!
//        let dropdown = DropDown()
//        private var isdropdownBtnClicked: Bool = false
//        let menuList = ["전체", "성미료", "성미관", "엠시티", "그레이스", "이율", "운정빌", "장수", "풍림"]
//
//        override func viewDidLoad() {
//            super.viewDidLoad()
//            self.tabBarController?.tabBar.isHidden = true
//            setUI()
//            setDropDown()
//
//            checkPwdTextField.addTarget(self, action: #selector(checkPwdTextFieldValueChanged(textField:)), for: .editingChanged)
//            hideKeyboard()
//        }
//
//        func setUI() {
//            idLabel.font = UIFont.suit(size: 16, family: .SemiBold)
//            idLabel.textColor = UIColor.text_black
//
//            resultOverlapIdLabel.text = ""
//            resultOverlapIdLabel.font = UIFont.suit(size: 12, family: .Regular)
//
//            pwdLabel.font = UIFont.suit(size: 16, family: .SemiBold)
//            pwdLabel.textColor = UIColor.text_black
//
//            checkPwdLabel.font = UIFont.suit(size: 16, family: .SemiBold)
//            checkPwdLabel.textColor = UIColor.text_black
//
//            resultCheckPwdLabel.text = ""
//            resultCheckPwdLabel.font = UIFont.suit(size: 12, family: .Regular)
//            resultCheckPwdLabel.textColor = UIColor(hexString: "FF0000")
//
//            nameLabel.font = UIFont.suit(size: 16, family: .SemiBold)
//            nameLabel.textColor = UIColor.text_black
//
//            phoneNumberLabel.font = UIFont.suit(size: 16, family: .SemiBold)
//            phoneNumberLabel.textColor = UIColor.text_black
//
//            dormitoryLabel.font = UIFont.suit(size: 16, family: .SemiBold)
//            dormitoryLabel.textColor = UIColor.text_black
//
//            roomLabel.font = UIFont.suit(size: 16, family: .SemiBold)
//            roomLabel.textColor = UIColor.text_black
//
//            idInputTextField.delegate = self
//            pwdInputTextField.delegate = self
//            checkPwdTextField.delegate = self
//
//            idInputTextField.layer.cornerRadius = 5
//            pwdInputTextField.layer.cornerRadius = 5
//            checkPwdTextField.layer.cornerRadius = 5
//
//            checkOverlapIdBtn.titleLabel?.font = UIFont.suit(size: 12, family: .Regular)
//            checkOverlapIdBtn.tintColor = .white
//            checkOverlapIdBtn.backgroundColor = .primary
//            checkOverlapIdBtn.layer.cornerRadius = 5
//
//            dormitoryTextField.placeholder = "기숙사 선택"
//            roomTextField.placeholder = "호실을 입력해주세요."
//
//            registerBtn.titleLabel?.font = UIFont.suit(size: 18, family: .Bold)
//            registerBtn.tintColor = .white
//            registerBtn.backgroundColor = .primary
//            registerBtn.layer.cornerRadius = 15
//        }
//
//        @IBAction func backBtnSelected(_ sender: Any) {
//            self.navigationController?.popViewController(animated: true)
//        }
//
//        @IBAction func checkOverlapIdBtnSelected(_ sender: Any) {
//            if let id = idInputTextField.text {
//                AF.request(
//                    "\(API.shared.base_url)/common/isAvailableId?id=\(id)",
//                    method: .get,
//                    encoding: JSONEncoding.default,
//                    headers: ["Accept": "text/plain"]
//                )
//                .responseString { response in
//                    if response.response?.statusCode == 200 {
//                        if let value = response.value {
//                            switch value {
//                            case "true":
//                                self.resultOverlapIdLabel.text = "사용 가능한 아이디입니다."
//                                self.resultOverlapIdLabel.textColor = .primary
//
//                            case "false":
//                                self.resultOverlapIdLabel.text = "이미 존재하는 아이디입니다."
//                                self.resultOverlapIdLabel.textColor = UIColor(hexString: "FF0000")
//
//                            default:
//                                return
//                            }
//                        }
//                    }
//                    else {
//                        print("error: \(response.error)")
//                    }
//                }
//            }
//        }
//
//        @objc final private func checkPwdTextFieldValueChanged(textField: UITextField) {
//            if checkPwdTextField.text != pwdInputTextField.text {
//                resultCheckPwdLabel.text = "비밀번호가 다릅니다."
//            }
//            else {
//                resultCheckPwdLabel.text = ""
//            }
//        }
//
//        @IBAction func dormitoryDropDownBtnSelected(_ sender: Any) {
//            isdropdownBtnClicked = !isdropdownBtnClicked
//            dormitoryDropDownBtn.setImage(isdropdownBtnClicked ? UIImage(systemName: "arrowtriangle.up.fill") : UIImage(systemName: "arrowtriangle.down.fill"), for: .normal)
//            dropdown.show()
//        }
//
//        @IBAction func registerBtnSelected(_ sender: Any) {
//            var phoneNumber = ""
//            if let pn1 = pn1TextField.text,
//               let pn2 = pn2TextField.text,
//               let pn3 = pn3TextField.text {
//                phoneNumber = pn1 + pn2 + pn3
//            }
//
//            if let id = idInputTextField.text,
//               let pwd = pwdInputTextField.text,
//               let name = nameTextField.text,
//               let dormitory = dormitoryTextField.text,
//               let room = roomTextField.text {
//                if id == "" || pwd == "" || name == "" || phoneNumber == "" || dormitory == "" || room == "" {
//                    let alert = UIAlertController(title: "모든 정보를 입력해주세요.", message: nil, preferredStyle: UIAlertController.Style.alert)
//                    alert.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))
//                    self.present(alert, animated: true)
//                    return
//                }
//
//                if resultOverlapIdLabel.text == "" || resultOverlapIdLabel.text == "이미 존재하는 아이디입니다." {
//                    let alert = UIAlertController(title: "아이디 중복확인을 해주세요.", message: nil, preferredStyle: UIAlertController.Style.alert)
//                    alert.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))
//                    self.present(alert, animated: true)
//                    return
//                }
//                if resultCheckPwdLabel.text == "비밀번호가 다릅니다." {
//                    let alert = UIAlertController(title: "비밀번호가 다릅니다.", message: nil, preferredStyle: UIAlertController.Style.alert)
//                    alert.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))
//                    self.present(alert, animated: true)
//                    return
//                }
//
//                let aes = AESUtil()
//                let securePwd = aes.setAES256Encrypt(string: pwd)
//                let model =  SignUpModel(id: id, password: securePwd, name: name, dormitoryName: dormitory, detailedAddress: room, phoneNumber: phoneNumber)
//
//                Repository.shared.signUp(signUpModel: model) { status, result in
//                    switch status {
//                    case .ok:
//                        if result == "회원가입 성공" {
//                            UserDefaults.standard.set(dormitory, forKey: "dormitoryName")
//                            self.navigationController?.popViewController(animated: true)
//                        }
//                        else if result == "이미 사용중인 id입니다." {
//                            let alert = UIAlertController(title: "이미 사용중인 id입니다", message: nil, preferredStyle: UIAlertController.Style.alert)
//                            alert.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))
//                            self.present(alert, animated: true)
//                        }
//                        else {
//                            let alert = UIAlertController(title: "존재하지 않는 기숙사입니다", message: nil, preferredStyle: UIAlertController.Style.alert)
//                            alert.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))
//                            self.present(alert, animated: true)
//                        }
//                        return
//
//                    default:
//                        break
//                    }
//                }
//
//            }
//        }
//
//    }
//
//    extension RegisterViewController {
//        func setDropDown() {
//            dropdown.dataSource = menuList
//            dropdown.anchorView = self.dormitoryDropView
//            dropdown.bottomOffset = CGPoint(x: 0, y: dormitoryDropView.bounds.height)
//            dropdown.selectionAction = { [weak self] (index, item) in
//                self!.dormitoryTextField.text = item
//                self!.isdropdownBtnClicked = !self!.isdropdownBtnClicked
//                self!.dormitoryDropDownBtn.setImage(self!.isdropdownBtnClicked ? UIImage(systemName: "arrowtriangle.up.fill") : UIImage(systemName: "arrowtriangle.down.fill"), for: .normal)
//            }
//
//            dropdown.cancelAction = { [weak self] in
//                self!.isdropdownBtnClicked = !self!.isdropdownBtnClicked
//                self!.dormitoryDropDownBtn.setImage(self!.isdropdownBtnClicked ? UIImage(systemName: "arrowtriangle.up.fill") : UIImage(systemName: "arrowtriangle.down.fill"), for: .normal)
//            }
//        }
//    }
//
//    extension RegisterViewController: UITextFieldDelegate {
//
//        func textFieldDidBeginEditing(_ textField: UITextField) {
//            textField.layer.borderWidth = 0.5
//            textField.layer.borderColor = UIColor.primary.cgColor
//        }
//
//        func textFieldDidEndEditing(_ textField: UITextField) {
//            textField.layer.borderWidth = 0.5
//            textField.layer.borderColor = UIColor(hexString: "C5C5C5").cgColor
//        }
//
//    }
