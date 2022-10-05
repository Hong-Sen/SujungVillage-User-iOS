//
//  LoginViewController.swift
//  SujungVillage-User
//
//  Created by 홍세은 on 2022/09/30.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var logoImg: UIImageView!
    @IBOutlet weak var googleLoginBtn: UIButton!
    
    var observer: NSKeyValueObservation?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setView()
        googleLoginBtn.addTarget(self, action: #selector(googleLoginButtonTapped), for: .touchDown)
    }
    
    func setView() {
        view.backgroundColor = .plight
        logoImg.image = UIImage(named: "logo")
    }
    
    @objc func googleLoginButtonTapped() {
        UserLoginManager.shared.doLoginWithGoogle(vc: self)
    }
}
