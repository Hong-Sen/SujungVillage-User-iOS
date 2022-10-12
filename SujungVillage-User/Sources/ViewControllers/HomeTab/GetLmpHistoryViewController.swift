//
//  GetLmpHistoryViewController.swift
//  SujungVillage-User
//
//  Created by 홍세은 on 2022/10/08.
//

import UIKit

class GetLmpHistoryViewController: UIViewController {
    
    @IBOutlet weak var allPlusLMPLabel: UILabel!
    @IBOutlet weak var plusLMPLabel: UILabel!
    @IBOutlet weak var allMinusLMPLabel: UILabel!
    @IBOutlet weak var minusLMPLabel: UILabel!
    @IBOutlet weak var tableIntroStackView: UIStackView!
    @IBOutlet weak var dateTableIntroView: UIView!
    @IBOutlet weak var dateTableIntroLabel: UILabel!
    @IBOutlet weak var scoreTableIntroView: UIView!
    @IBOutlet weak var scoreTableIntroLabel: UILabel!
    @IBOutlet weak var reasonTableIntroView: UIView!
    @IBOutlet weak var reasonTableIntroLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    private let homeViewModel = HomeViewModel()
    private let LMPviewModel = LMPHistoryViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        fetchView()
        setTableView()
    }
    
    func setUI() {
        allPlusLMPLabel.font = UIFont.suit(size: 16, family: .SemiBold)
        allPlusLMPLabel.textColor = UIColor.text_black
        
        plusLMPLabel.font = UIFont.suit(size: 17, family: .SemiBold)
        plusLMPLabel.textColor = UIColor.primary
        
        allMinusLMPLabel.font = UIFont.suit(size: 16, family: .SemiBold)
        allMinusLMPLabel.textColor = UIColor.text_black
        
        minusLMPLabel.font = UIFont.suit(size: 17, family: .SemiBold)
        minusLMPLabel.textColor = UIColor.primary
        
        if(LMPviewModel.historyArr.count == 0) {
            tableIntroStackView.isHidden = true
            return
        }
        
        dateTableIntroView.layer.borderWidth = 1
        dateTableIntroView.layer.borderColor = UIColor.primary.cgColor
        dateTableIntroView.backgroundColor = UIColor(hexString: "FFD250")
        dateTableIntroView.roundCorners(corners: [.topLeft], radius: 10)
        
        scoreTableIntroView.layer.borderWidth = 1
        scoreTableIntroView.layer.borderColor = UIColor.primary.cgColor
        scoreTableIntroView.backgroundColor = UIColor(hexString: "FFD250")
        
        reasonTableIntroView.layer.borderWidth = 1
        reasonTableIntroView.layer.borderColor = UIColor.primary.cgColor
        reasonTableIntroView.backgroundColor = UIColor(hexString: "FFD250")
        reasonTableIntroView.roundCorners(corners: [.topRight], radius: 10)
        
        dateTableIntroLabel.font = UIFont.suit(size: 12, family: .Bold)
        dateTableIntroLabel.textColor = .white
        
        scoreTableIntroLabel.font = UIFont.suit(size: 12, family: .Bold)
        scoreTableIntroLabel.textColor = .white
        
        reasonTableIntroLabel.font = UIFont.suit(size: 12, family: .Bold)
        reasonTableIntroLabel.textColor = .white
    }
    
    func fetchView() {
        homeViewModel.onUpdated = {[weak self] in
            DispatchQueue.main.async {
                if let plus = self?.homeViewModel.plusLMP, let minus = self?.homeViewModel.minusLMP {
                    self?.plusLMPLabel.text = "\(plus)점"
                    self?.minusLMPLabel.text = "\(minus)점"
                }
            }
        }
    }
    
    @IBAction func backBtnSelected(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension GetLmpHistoryViewController: UITableViewDelegate, UITableViewDataSource {
    func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        let nibName = UINib(nibName: "LMPHistoryTableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "LMPHistoryTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return LMPviewModel.historyArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LMPHistoryTableViewCell", for: indexPath) as! LMPHistoryTableViewCell
        
        if(indexPath.row == LMPviewModel.historyArr.count-1) {
            cell.dateView.roundCorners(corners: [.bottomLeft], radius: 10)
            cell.reasonView.roundCorners(corners: [.bottomRight], radius: 10)
        }
        
        var date = LMPviewModel.historyArr[indexPath.row].regDate
        let endIdx = date.index(date.startIndex, offsetBy: 10)
        date = String(date[...endIdx])
        
        cell.dateLabel.text = "\(date)"
        cell.scoreLabel.text = "\(LMPviewModel.historyArr[indexPath.row].score)"
        cell.reasonLabel.text  = "\(LMPviewModel.historyArr[indexPath.row].reason)"
        
        return cell
    }
    
}
