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
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        observer = defaults.observe(\.needLogin, options: [.initial, .new], changeHandler: { (default, change) in
            if !self.defaults.needLogin {
                UserInfoViewModel.shared.fetchResidentInfo(year: Calendar.current.component(.year, from: Date()), month: Calendar.current.component(.month, from: Date()))
                self.dismiss(animated: true)
            }
        })
        
        autoLoginBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.autoLoginTapped)))
        autoLoginBtn.isUserInteractionEnabled = true
        hideKeyboard()
    }
    
    func setView() {
        self.tabBarController?.tabBar.isHidden = true
        view.backgroundColor = .plight
        logoImg.image = UIImage(named: "logo")
        bottomView.layer.cornerRadius = 20
        bottomView.addShadow(location: .top, opacity: 0.12, radius: 20)
        bottomView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = false
        
        loginLabel.font = UIFont.suit(size: 24, family: .SemiBold)
        idTextField.layer.cornerRadius = idTextField.frame.size.height/2
        idTextField.layer.masksToBounds = true
        idTextField.placeholder = "ID"
        idTextField.backgroundColor = UIColor(hexString: "EAEAEA")
        idTextField.setPadding(left: 15, right: 10)
        
        pwdTextField.layer.cornerRadius = pwdTextField.frame.size.height/2
        pwdTextField.layer.masksToBounds = true
        pwdTextField.placeholder = "PW"
        pwdTextField.backgroundColor = UIColor(hexString: "EAEAEA")
        pwdTextField.setPadding(left: 15, right: 10)
        
        autoLoginLabel.font = UIFont.suit(size: 14, family: .Medium)
        
        loginBtn.tintColor = .white
        loginBtn.titleLabel?.font = UIFont.suit(size: 14, family: .Bold)
        loginBtn.backgroundColor = .primary
        loginBtn.layer.cornerRadius = 10
        
        signUpBtn.tintColor = .white
        signUpBtn.titleLabel?.font = UIFont.suit(size: 14, family: .Bold)
        signUpBtn.backgroundColor = .primary
        signUpBtn.layer.cornerRadius = 10
        
    }
    
    func setAutoLoginBtn() {
        autoLoginBtn.image = UIImage(systemName: isAutoLogined ? "checkmark.square.fill" : "square")
    }
    
    @objc func autoLoginTapped(sender: UITapGestureRecognizer) {
        isAutoLogined = !isAutoLogined
        setAutoLoginBtn()
    }
    
    @IBAction func loginBtnSelected(_ sender: Any) {
        if let id = idTextField.text, let pwd = pwdTextField.text, let fcmToken = UserDefaults.standard.string(forKey: "fcmToken") {
            let aes = AESUtil()
            let encodedPwd = aes.setAES256Encrypt(string: pwd)
 
            UserLoginManager.shared.doLoginInVC(id: id, pwd: encodedPwd, fcmToken: fcmToken) { result in
                if result {
                    self.defaults.autoLogin = self.isAutoLogined
                    self.defaults.needLogin = false
                }
                else {
                    let alert = UIAlertController(title: "일치하는 계정이 없습니다.", message: nil, preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
                    self.present(alert, animated: true)
                }
            }
        }
    }
    
    @IBAction func signUpBtnSelected(_ sender: Any) {
        guard let signUpVC = self.storyboard?.instantiateViewController(withIdentifier: "RegisterViewController") as? RegisterViewController else { return }
        self.navigationController?.pushViewController(signUpVC, animated: true)
    }
}
