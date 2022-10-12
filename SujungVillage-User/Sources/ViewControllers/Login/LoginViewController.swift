//
//  LoginViewController.swift
//  SujungVillage-User
//
//  Created by 홍세은 on 2022/09/30.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var logoImg: UIImageView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var pwdTextField: UITextField!
    @IBOutlet weak var autoLoginBtn: UIImageView!
    @IBOutlet weak var autoLoginLabel: UILabel!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var signUpBtn: UIButton!
    private var isAutoLogined: Bool = false
    var observer: NSKeyValueObservation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        
//        observer = UserDefaults.standard.observe(\.isLogined, options: [.initial, .new], changeHandler: { (defaults, change) in
//            self.dismiss(animated: true)
//        })
        
        autoLoginBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.autoLoginTapped)))
        autoLoginBtn.isUserInteractionEnabled = true
    }
    
    func setView() {
        self.tabBarController?.tabBar.isHidden = true
        view.backgroundColor = .plight
        logoImg.image = UIImage(named: "logo")
        bottomView.layer.cornerRadius = 20
        bottomView.layer.shadowOpacity = 0.08
        bottomView.layer.shadowColor = UIColor.black.cgColor
        bottomView.layer.shadowOffset = CGSize(width: 0, height: 0)
        bottomView.layer.shadowRadius = 20
        bottomView.layer.masksToBounds = false
        
        loginLabel.font = UIFont.suit(size: 24, family: .SemiBold)
        idTextField.layer.cornerRadius = 20
        idTextField.layer.masksToBounds = true
        idTextField.placeholder = "ID"
        idTextField.backgroundColor = UIColor(hexString: "EAEAEA")
        idTextField.setPadding(left: 10, right: 10)
        
        pwdTextField.layer.cornerRadius = 20
        pwdTextField.layer.masksToBounds = true
        pwdTextField.placeholder = "PW"
        pwdTextField.backgroundColor = UIColor(hexString: "EAEAEA")
        pwdTextField.setPadding(left: 10, right: 10)
        
        autoLoginLabel.font = UIFont.suit(size: 12, family: .Medium)
        
        loginBtn.tintColor = UIColor.primary
        loginBtn.titleLabel?.font = UIFont.suit(size: 14, family: .Bold)
        
        signUpBtn.tintColor = .primary
        signUpBtn.titleLabel?.font = UIFont.suit(size: 10, family: .Bold)
        
    }
    
    func setAutoLoginBtn() {
        autoLoginBtn.image = UIImage(systemName: isAutoLogined ? "checkmark.square.fill" : "square")
    }
    
    @objc func autoLoginTapped(sender: UITapGestureRecognizer) {
        isAutoLogined = !isAutoLogined
        setAutoLoginBtn()
    }
    
    @IBAction func loginBtnSelected(_ sender: Any) {
        // FIX: 자동로그인 기능 추가
        
        if let id = idTextField.text, let pwd = pwdTextField.text {
            let aes = AESUtil()
            let encodedPwd = aes.setAES256Encrypt(string: pwd)
            UserLoginManager.shared.doLogin(id: id, pwd: encodedPwd, fcmToken: "")
            if UserDefaults.standard.isLogined {
                self.dismiss(animated: true)
            }
        }
    }
    
    @IBAction func signUpBtnSelected(_ sender: Any) {
        guard let signUpVC = self.storyboard?.instantiateViewController(withIdentifier: "RegisterViewController") as? RegisterViewController else { return }
        self.navigationController?.pushViewController(signUpVC, animated: true)
    }
}
