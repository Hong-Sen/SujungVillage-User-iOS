//
//  SplashViewController.swift
//  SujungVillage-User
//
//  Created by 홍세은 on 2022/12/12.
//

import UIKit
import Lottie

class SplashViewController: UIViewController {
    
    var animationView = AnimationView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLottie()
        setUI()
        self.animationView.play()
        
    }

    func setUI() {
        self.view.backgroundColor = .plight
        self.view.addSubview(animationView)
        animationView.frame = CGRect(x: 0.5, y: 0.5, width: 120, height: 120)
        animationView.center = self.view.center
        animationView.contentMode = .scaleAspectFit
        
    }
    
    func setLottie() {
        animationView = .init(name: "splash")
        animationView.animationSpeed = 0.9
    }
    
}
