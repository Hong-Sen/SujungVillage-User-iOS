//
//  HomeTabViewController.swift
//  SujungVillage-User
//
//  Created by 홍세은 on 2022/09/28.
//

import UIKit
import FSCalendar

class HomeTabViewController: UIViewController {
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var alarmBtn: UIBarButtonItem!
    @IBOutlet weak var backgroundImg: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var dormitoryLabel: UILabel!
    @IBOutlet weak var rewardPointLabel: UILabel!
    @IBOutlet weak var bottomView: UIView!
    
    @IBOutlet weak var exeatView: UIStackView!
    @IBOutlet weak var exeatLabel: UILabel!
    @IBOutlet weak var rollCallView: UIStackView!
    @IBOutlet weak var rollCallLabel: UILabel!
    @IBOutlet weak var noticeView: UIStackView!
    @IBOutlet weak var noticeLabel: UILabel!
    @IBOutlet weak var rewardCheckView: UIStackView!
    @IBOutlet weak var rewardCheckLabel: UILabel!
    @IBOutlet weak var calendarView: FSCalendar!
    
    private let viewModel = UserInfoViewModel.shared
    private var observer: NSKeyValueObservation?
    private let dateFormatter = DateFormatter()
    private var curYear = Calendar.current.component(.year, from: Date())
    private var curMonth = Calendar.current.component(.month, from: Date())
    private let userDefault = UserDefaults.standard
    private var isLongTermExeatDay: Bool = false
    
    private var rollcallDayList: [Day] = []
    private var appliedRollcallDayList: [Day] = []
    private var appliedExeatDayList: [Day] = []
    private var appliedLongTermExeatDayList: [AppliedLongTermExeatDay] = []
    private var appliedLongTermExeatDaysAllDateList: [LongTermExeatModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if userDefault.needLogin { 
            presentLoginVC()
        }
        
        fetchView()
        setUI()
        setCalendarView()
        viewModel.fetchResidentInfo(year: curYear, month: curMonth)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if userDefault.needLogin {
            guard let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginNavigationController") as? UINavigationController else { return }
            loginVC.modalPresentationStyle = .fullScreen
            loginVC.modalTransitionStyle = .coverVertical
            self.present(loginVC, animated: true)
        } 
        observer = userDefault.observe(\.needLogin, options: [.initial, .new], changeHandler: { (defaults, change) in
            if self.userDefault.needLogin {
                self.viewModel.fetchResidentInfo(year: self.curYear, month: self.curMonth)
            }
        })
        
        fetchView()
        setUI()
        setCalendarView()
        viewModel.fetchResidentInfo(year: curYear, month: curMonth)
        print("Home ViewWillAppear")
    }
    
    func presentLoginVC() {
        guard let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginNavigationController") as? UINavigationController else { return }
        loginVC.modalPresentationStyle = .fullScreen
        loginVC.modalTransitionStyle = .crossDissolve
        self.present(loginVC, animated: true)
    }
    
    func setUI() {
        self.view?.backgroundColor = UIColor(hexString: "FFA114")
        
        backgroundImg.image = UIImage(named: "home_background")
        backgroundImg.contentMode = .scaleToFill
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        navigationBar.standardAppearance = appearance
        
        navigationBar.tintColor = .white
        alarmBtn.image = UIImage(systemName: "bell")
        
        nameLabel.font = UIFont.suit(size: 34, family: .Bold)
        nameLabel.textColor = .white
        
        welcomeLabel.font = UIFont.suit(size: 22, family: .Bold)
        welcomeLabel.textColor = .white
        welcomeLabel.text = "님 반갑습니다!"
        
        dormitoryLabel.font = UIFont.suit(size: 14, family: .Medium)
        dormitoryLabel.textColor = UIColor(hexString: "FFEEBD")
        
        rewardPointLabel.font = UIFont.suit(size: 14, family: .Medium)
        rewardPointLabel.textColor = UIColor(hexString: "FFEEBD")
        
        bottomView.roundCorners(corners: [.topLeft, .topRight], radius: 20)
        
        bottomView.layer.shadowColor = UIColor.black.cgColor
        bottomView.layer.shadowOpacity = 0.3
        bottomView.layer.shadowRadius = 3.0
        bottomView.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        
        exeatLabel.font = UIFont.suit(size: 11, family: .Medium)
        exeatLabel.textColor = UIColor(hexString: "878787")
        
        rollCallLabel.font = UIFont.suit(size: 11, family: .Medium)
        rollCallLabel.textColor = UIColor(hexString: "878787")
        
        noticeLabel.font = UIFont.suit(size: 11, family: .Medium)
        noticeLabel.textColor = UIColor(hexString: "878787")
        
        rewardCheckLabel.font = UIFont.suit(size: 11, family: .Medium)
        rewardCheckLabel.textColor = UIColor(hexString: "878787")
        
        exeatView.tag = 1000
        rollCallView.tag = 1001
        noticeView.tag = 1002
        rewardCheckView.tag = 1003
        
        exeatView.isUserInteractionEnabled = true
        rollCallView.isUserInteractionEnabled = true
        noticeView.isUserInteractionEnabled = true
        rewardCheckView.isUserInteractionEnabled = true
        
        exeatView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.viewTapped)))
        rollCallView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.viewTapped)))
        noticeView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.viewTapped)))
        rewardCheckView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.viewTapped)))
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
    }
    
    func setCalendarView() {
        calendarView.delegate = self
        calendarView.dataSource = self
        
        calendarView.backgroundColor = .white
        calendarView.scrollEnabled = false
        calendarView.locale = Locale(identifier: "ko_KR")
        
        calendarView.appearance.titleSelectionColor = .black
        calendarView.appearance.headerTitleFont = UIFont.suit(size: 22, family: .Bold)
        calendarView.appearance.headerTitleColor = UIColor(hexString: "0E0E0E")
        calendarView.appearance.headerDateFormat = "MM월"
        calendarView.appearance.headerTitleAlignment = .center
        
        calendarView.appearance.weekdayFont = UIFont.suit(size: 12, family: .Medium)
        calendarView.appearance.weekdayTextColor = UIColor(hexString: "878787")
        
        calendarView.appearance.titleFont = UIFont.suit(size: 14, family: .Medium)
        calendarView.appearance.titleDefaultColor = UIColor(hexString: "0E0E0E")
        calendarView.appearance.titleTodayColor = .primary
        calendarView.appearance.todayColor = .white
        
        calendarView.placeholderType = .none
    }
    
    func fetchView() {
        viewModel.onUpdated = {[weak self] in
            DispatchQueue.main.async { [self] in
                self?.nameLabel.text = self?.viewModel.userName
                if let dormitory = self?.viewModel.dormitoryName {
                    self?.dormitoryLabel.text = "\(dormitory) 기숙사"
                }
                if let plus = self?.viewModel.plusLMP, let minus = self?.viewModel.minusLMP {
                    self?.rewardPointLabel.text = "상점 : \(plus)점    |    벌점 : \(minus)점"
                }
                if let rollcalls = self?.viewModel.rollcallDays,
                   let appliedRollcalls = self?.viewModel.appliedRollcallDays,
                   let appliedExeats = self?.viewModel.appliedExeatDays,
                   let appliedLongTermExeats = self?.viewModel.appliedLongTermExeatDays,
                   let appliedLongTermExeatDaysAllDates = self?.viewModel.appliedLongTermExeatDaysAllDates {
                    self?.rollcallDayList = rollcalls
                    self?.appliedRollcallDayList = appliedRollcalls
                    self?.appliedExeatDayList = appliedExeats
                    self?.appliedLongTermExeatDayList = appliedLongTermExeats
                    self?.appliedLongTermExeatDaysAllDateList = appliedLongTermExeatDaysAllDates
                    self?.calendarView.reloadData()
                }
            }
        }
    }
    
    @objc func viewTapped(sender: UITapGestureRecognizer) {
        if let tag = sender.view?.tag {
            switch tag {
            case 1000:
                guard let exeatVC = self.storyboard?.instantiateViewController(withIdentifier: "ApplyExeatViewController") as? ApplyExeatViewController else { return }
                exeatVC.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(exeatVC, animated: true)
                return
                
            case 1001:
                Repository.shared.isRollcallAvailableNow { status, result in
                    switch status {
                    case .ok:
                        if result == "true" {
                            guard let rollcallVC = self.storyboard?.instantiateViewController(withIdentifier: "ApplyRollCallViewController") as? ApplyRollCallViewController else { return }
                            rollcallVC.hidesBottomBarWhenPushed = true
                            self.navigationController?.pushViewController(rollcallVC, animated: true)
                        }
                        else {
                            let alert = UIAlertController(title: "현재 점호를 진행하고 있지 않습니다.", message: nil, preferredStyle: UIAlertController.Style.alert)
                            alert.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))
                            self.present(alert, animated: true)
                        }
                    default:
                        print("isRollcallAvailbaleNow error: \(status)")
                    }
                }

                return
                
            case 1002:
                guard let noticeVC = self.storyboard?.instantiateViewController(withIdentifier: "GetNoticeViewController") as? GetNoticeViewController else { return }
                noticeVC.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(noticeVC, animated: true)
                return
                
            case 1003:
                guard let LMPHistoryVC = self.storyboard?.instantiateViewController(withIdentifier: "GetLmpHistoryViewController") as? GetLmpHistoryViewController else { return }
                LMPHistoryVC.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(LMPHistoryVC, animated: true)
                return
                
            default:
                return
            }
        }
    }
    
    @IBAction func moveToPrevMonthSelected(_ sender: Any) {
        self.moveCurrentPage(moveUp: true)
    }
    
    @IBAction func moveToNextMonthSelected(_ sender: Any) {
        self.moveCurrentPage(moveUp: false)
    }
}


extension HomeTabViewController: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    private func moveCurrentPage(moveUp: Bool) {
        let _calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.month = moveUp ? -1 : 1
        
        calendarView.currentPage = _calendar.date(byAdding: dateComponents, to: calendarView.currentPage)!
        calendarView.setCurrentPage(calendarView.currentPage, animated: true)
        
        curYear = _calendar.component(.year, from: calendarView.currentPage)
        curMonth =  _calendar.component(.month, from: calendarView.currentPage)
        print("YEAR: \(curYear) / Month: \(curMonth)")
        viewModel.fetchResidentInfo(year: curYear, month: curMonth)
    }

    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
        var day = date.toStringExceptZero()
        
        // 무단 외박일
        if rollcallDayList.filter({"\(curYear)-\(curMonth)-\($0.day)" == day}).count > 0  && appliedRollcallDayList.filter({"\(curYear)-\(curMonth)-\($0.day)" == day}).count == 0 {
            return UIColor(hexString: "FF7979")
        }
        
        // 점호
        else if appliedRollcallDayList.filter({"\(curYear)-\(curMonth)-\($0.day + 1)" == day}).count > 0 {
            return UIColor(hexString: "FFDB73")
        }
        
        // 외박
        else if appliedExeatDayList.filter({"\(curYear)-\(curMonth)-\($0.day)" == day}).count > 0 {
            return .primary
        }
        
        // 장기 외박
        else if appliedLongTermExeatDaysAllDateList.filter({$0.date == day}).count > 0 {
            return .green
        }
        
        return .white
    }
    
    // select시 색상 변경 방지
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillSelectionColorFor date: Date) -> UIColor? {
        var day = date.toStringExceptZero()
        
        // 무단 외박일
        if rollcallDayList.filter({"\(curYear)-\(curMonth)-\($0.day)" == day}).count > 0  && appliedRollcallDayList.filter({"\(curYear)-\(curMonth)-\($0.day)" == day}).count == 0 {
            return UIColor(hexString: "FF7979")
        }
        
        // 점호
        else if appliedRollcallDayList.filter({"\(curYear)-\(curMonth)-\($0.day + 1)" == day}).count > 0 {
            return UIColor(hexString: "FFDB73")
        }
        
        // 외박
        else if appliedExeatDayList.filter({"\(curYear)-\(curMonth)-\($0.day)" == day}).count > 0 {
            return .primary
        }
        
        // 장기 외박
        else if appliedLongTermExeatDaysAllDateList.filter({$0.date == day}).count > 0 {
            return .green
        }
        
        return .white
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        var day = date.toStringExceptZero()

        if rollcallDayList.filter({"\(curYear)-\(curMonth)-\($0.day)" == day}).count > 0  && appliedRollcallDayList.filter({"\(curYear)-\(curMonth)-\($0.day)" == day}).count == 0 {
            let unRollCallVC = UnRollCallAlertViewController()
            unRollCallVC.date = dateFormatter.string(from: date)
            unRollCallVC.modalPresentationStyle = .overFullScreen
            unRollCallVC.modalTransitionStyle = .crossDissolve
            present(unRollCallVC, animated: true, completion: nil)
        }
        
        else if appliedRollcallDayList.filter({"\(curYear)-\(curMonth)-\($0.day + 1)" == day}).count > 0 {
            let rollcallVC = RollCallAlertViewController()
            rollcallVC.rollcallId = appliedRollcallDayList.filter({("\(curYear)-\(curMonth)-\($0.day + 1)" == day)})[0].id
            rollcallVC.date = dateFormatter.string(from: date)
            rollcallVC.modalPresentationStyle = .overFullScreen
            rollcallVC.modalTransitionStyle = .crossDissolve
            present(rollcallVC, animated: true, completion: nil)
        }
        
        else if appliedExeatDayList.filter({"\(curYear)-\(curMonth)-\($0.day)" == day}).count > 0 {
            let exeatVC = ExeatAlertViewController()
            exeatVC.exeatId = appliedExeatDayList.filter({("\(curYear)-\(curMonth)-\($0.day)" == day)})[0].id
            exeatVC.date = dateFormatter.string(from: date)
            exeatVC.type = .short
            exeatVC.modalPresentationStyle = .overFullScreen
            exeatVC.modalTransitionStyle = .crossDissolve
            present(exeatVC, animated: true, completion: nil)
        }
        
        else if appliedLongTermExeatDaysAllDateList.filter({$0.date == day}).count > 0 {
            let exeatVC = ExeatAlertViewController()
            exeatVC.exeatId = appliedLongTermExeatDaysAllDateList.filter({$0.date == day})[0].id
            exeatVC.date = dateFormatter.string(from: date)
            exeatVC.type = .long
            exeatVC.modalPresentationStyle = .overFullScreen
            exeatVC.modalTransitionStyle = .crossDissolve
            present(exeatVC, animated: true, completion: nil)
        }
    }
}
