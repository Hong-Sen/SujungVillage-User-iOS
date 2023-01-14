//
//  RegisterView.swift
//  SujungVillage-User
//
//  Created by 홍세은 on 2023/01/06.
//

import UIKit
import DropDown
import Alamofire
import CryptoSwift

class RegisterView: UIView {
    
    private let navigationBar: UINavigationBar = {
        let navibar = UINavigationBar()
        navibar.translatesAutoresizingMaskIntoConstraints = false
        navibar.isTranslucent = false
        return navibar
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = .white
        return scrollView
    }()
    
    private lazy var allView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var idLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "아이디"
        label.textColor = .text_black
        label.font = UIFont.suit(size: 16, family: .SemiBold)
        return label
    }()
    
    private lazy var idTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.setPadding(left: 5, right: 5)
        tf.layer.borderColor = UIColor.textField_gray.cgColor
        tf.layer.borderWidth = 1
        tf.roundCorners(corners: [.allCorners], radius: 5)
        tf.textColor = .text_black
        return tf
    }()
    
    private lazy var checkIdOverlapBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("중복 확인", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.suit(size: 12, family: .Regular)
        btn.backgroundColor = .primary
        btn.roundCorners(corners: [.allCorners], radius: 5)
        btn.addTarget(self, action: #selector(checkIdOverlap), for: .touchUpInside)
        return btn
    }()
    
    private lazy var idOverlapResultLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.font = UIFont.suit(size: 12, family: .Regular)
        return label
    }()
    
    private lazy var pwdLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "비밀번호"
        label.textColor = .text_black
        label.font = UIFont.suit(size: 16, family: .SemiBold)
        return label
    }()
    
    private lazy var pwdTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.setPadding(left: 5, right: 5)
        tf.textColor = .text_black
        tf.layer.borderColor = UIColor.textField_gray.cgColor
        tf.layer.borderWidth = 1
        tf.roundCorners(corners: [.allCorners], radius: 5)
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private lazy var checkPwdLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "비밀번호 확인"
        label.textColor = .text_black
        label.font = UIFont.suit(size: 16, family: .SemiBold)
        return label
    }()
    
    private lazy var checkPwdTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.setPadding(left: 5, right: 5)
        tf.layer.borderColor = UIColor.textField_gray.cgColor
        tf.layer.borderWidth = 1
        tf.roundCorners(corners: [.allCorners], radius: 5)
        tf.textColor = .text_black
        tf.isSecureTextEntry = true
        tf.addTarget(self, action: #selector(checkPwdTextFieldValueChanged(textField: )), for: .editingChanged)
        return tf
    }()
    
    private lazy var pwdSameResultLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.textColor = .red
        label.font = UIFont.suit(size: 12, family: .Regular)
        return label
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "이름"
        label.textColor = .text_black
        label.font = UIFont.suit(size: 16, family: .SemiBold)
        return label
    }()
    
    private lazy var nameTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.setPadding(left: 5, right: 5)
        tf.layer.borderColor = UIColor.textField_gray.cgColor
        tf.layer.borderWidth = 1
        tf.roundCorners(corners: [.allCorners], radius: 5)
        tf.textColor = .text_black
        return tf
    }()
    
    private lazy var phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "전화번호"
        label.textColor = .text_black
        label.font = UIFont.suit(size: 16, family: .SemiBold)
        return label
    }()
    
    private lazy var phoneNumberTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.setPadding(left: 5, right: 5)
        tf.layer.borderColor = UIColor.textField_gray.cgColor
        tf.layer.borderWidth = 1
        tf.roundCorners(corners: [.allCorners], radius: 5)
        tf.textColor = .text_black
        return tf
    }()
    
    private lazy var dormitoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "기숙사"
        label.textColor = .text_black
        label.font = UIFont.suit(size: 16, family: .SemiBold)
        return label
    }()
    
    private lazy var dormitoryView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.textField_gray.cgColor
        view.roundCorners(corners: [.allCorners], radius: 5)
        return view
    }()
    
    private lazy var dormitoryNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "기숙사 선택"
        label.textColor = UIColor(hexString: "818181")
        label.font = UIFont.suit(size: 12, family: .Regular)
        return label
    }()
    
    private lazy var dropDownBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(systemName: "arrowtriangle.down.fill"), for: .normal)
        btn.tintColor = .text_black
        btn.addTarget(self, action: #selector(dormitoryDropDownBtnSelected), for: .touchUpInside)
        return btn
    }()
    
    private lazy var roomLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "기숙사 호실"
        label.textColor = .text_black
        label.font = UIFont.suit(size: 16, family: .SemiBold)
        return label
    }()
    
    private lazy var roomTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.setPadding(left: 5, right: 5)
        tf.layer.borderColor = UIColor.textField_gray.cgColor
        tf.layer.borderWidth = 1
        tf.roundCorners(corners: [.allCorners], radius: 5)
        tf.textColor = .text_black
        tf.placeholder = "호실을 입력해주세요"
        tf.font = UIFont.suit(size: 12, family: .Regular)
        return tf
    }()
    
    private lazy var agreeTermsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "이용 약관 동의"
        label.textColor = .text_black
        label.font = UIFont.suit(size: 16, family: .SemiBold)
        return label
    }()
    
    private lazy var agreeAllTermsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderColor = UIColor.textField_gray.cgColor
        view.layer.borderWidth = 1
        view.roundCorners(corners: [.allCorners], radius: 5)
        return view
    }()
    
    private lazy var checkAllTermsBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        btn.tintColor = UIColor.textField_gray
        btn.addTarget(self, action: #selector(termAllAgree), for: .touchUpInside)
        return btn
    }()
    
    private lazy var agreeAllTermsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "네, 모든 약관에 동의합니다."
        label.textColor = UIColor(hexString: "818181")
        label.font = UIFont.suit(size: 14, family: .Medium)
        return label
    }()
    
    private lazy var checkTerm1Btn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        btn.tintColor = UIColor.textField_gray
        btn.addTarget(self, action: #selector(term1IsAgree), for: .touchUpInside)
        return btn
    }()
    
    private lazy var term1Label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "이용 약관 동의"
        label.textColor = UIColor(hexString: "818181")
        label.font = UIFont.suit(size: 14, family: .Regular)
        return label
    }()
    
    private lazy var term1EssentialLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = " (필수) "
        label.textColor = .pdark
        label.font = UIFont.suit(size: 14, family: .Regular)
        return label
    }()
    
    private lazy var term1ViewMoreBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("[더보기]", for: .normal)
        btn.tintColor = .pdark
        btn.titleLabel?.font = UIFont.suit(size: 14, family: .Regular)
        return btn
    }()
    
    lazy var term1ContentScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = UIColor(hexString: "E8E8E8")
        return scrollView
    }()
    
    private lazy var term1ContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(hexString: "E8E8E8")
        return view
    }()
    
    private lazy var term1ContentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = readTextFile(filename: "수정마을_이용약관.txt")
        label.textColor = .text_black
        label.numberOfLines = 0
        label.font = UIFont.suit(size: 14, family: .Regular)
        return label
    }()
    
    private lazy var checkTerm2Btn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        btn.tintColor = UIColor.textField_gray
        btn.addTarget(self, action: #selector(term2IsAgree), for: .touchUpInside)
        return btn
    }()
    
    private lazy var term2Label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "개인정보 처리 방침 동의"
        label.textColor = UIColor(hexString: "818181")
        label.font = UIFont.suit(size: 14, family: .Regular)
        return label
    }()
    
    private lazy var term2EssentialLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = " (필수) "
        label.textColor = .pdark
        label.font = UIFont.suit(size: 14, family: .Regular)
        return label
    }()
    
    private lazy var term2ViewMoreBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("[더보기]", for: .normal)
        btn.tintColor = .pdark
        btn.titleLabel?.font = UIFont.suit(size: 14, family: .Regular)
        return btn
    }()
    
    private lazy var term2ContentScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = UIColor(hexString: "E8E8E8")
        return scrollView
    }()
    
    private lazy var term2ContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(hexString: "E8E8E8")
        return view
    }()
    
    private lazy var term2ContentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = readTextFile(filename: "수정마을_개인정보처리방침.txt")
        label.textColor = .text_black
        label.numberOfLines = 0
        label.font = UIFont.suit(size: 14, family: .Regular)
        return label
    }()
    
    private lazy var registerBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("회원가입", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .primary
        btn.titleLabel?.font = UIFont.suit(size: 18, family: .Bold)
        btn.roundCorners(corners: [.allCorners], radius: 15)
        return btn
    }()
    
    let dropdown = DropDown()
    private var isdropdownBtnClicked: Bool = false
    private var showTerm1Content: Bool = false
    private var showTerm2Content: Bool = false
    private var term1AgreeBtnClicked: Bool = false
    private var term2AgreeBtnClicked: Bool = false
    private var allTermAgreeBtnClicked: Bool = false
    let menuList = ["전체", "성미료", "성미관", "엠시티", "그레이스", "이율", "운정빌", "장수", "풍림"]
    var popVCHandler: (() -> Void)?
    var presentAlertHandler: (() -> Void)?
    
    func setupPopVCHandler(_ handler: @escaping() -> Void) {
        popVCHandler = handler
    }
    
    func setupPresentAlertHandler(_ handler: @escaping() -> Void) {
        presentAlertHandler = handler
    }
    
    init() {
        super.init(frame: .zero)
        setupViews()
        setDropDown()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        setupNaviBar()
        setupScrollView()
        setupAllView()
        setupIdLabel()
        setupIdTextField()
        setupCheckIdOverlapBtn()
        setupIdOverlapResultLabel()
        setupPwdLabel()
        setupPwdTextField()
        setupCheckPwdLabel()
        setupCheckPWdTextField()
        setupPwdSameResultLabel()
        setupNameLabel()
        setupNameTextField()
        setupPhoneNumberLabel()
        setupPhoneNumbeTextField()
        setupDormitoryLabel()
        setupDormitoryView()
        setupDormitoryNameLabel()
        setupDropDownBtn()
        setupRoomLabel()
        setupRoomTextField()
        setupAgreeTermsLabel()
        setupAgreeAllTermsView()
        setupCheckAllTermsBtn()
        setupAgreeAllTermsLabel()
        setupCheckTerm1Btn()
        setupTerm1Label()
        setupTerm1EssentialLabel()
        //        setupTerm1ViewMoreBtn()
        setupTerm1ScrollView()
        setupTerm1ContentView()
        setupTerm1ContentLabel()
        setupCheckTerm2Btn()
        setupTerm2Label()
        setupTerm2EssentialLabel()
        //        setupTerm2ViewMoreBtn()
        setupTerm2ScrollView()
        setupTerm2ContentView()
        setupTerm2ContentLabel()
        setupRegisterBtn()
    }
    
    private func setNaviBar() {
        let navItem = UINavigationItem(title: "회원가입")
        navItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(popVC))
        navItem.leftBarButtonItem?.tintColor = .black
        navigationBar.setItems([navItem], animated: true)
    }
    
    private func setupNaviBar() {
        addSubview(navigationBar)
        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            navigationBar.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
        ])
        setNaviBar()
    }
    
    private func setupScrollView() {
        self.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            scrollView.widthAnchor.constraint(equalTo: self.widthAnchor),
            scrollView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    private func setupAllView() {
        scrollView.addSubview(allView)
        
        NSLayoutConstraint.activate([
            allView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            allView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            allView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            allView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
        
        
        let contentViewCenterY = allView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor)
        contentViewCenterY.priority = .defaultLow
        
        let contentViewHeight = allView.heightAnchor.constraint(greaterThanOrEqualTo: self.heightAnchor)
        contentViewHeight.priority = .defaultLow
        
        NSLayoutConstraint.activate([
            allView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            contentViewCenterY,
            contentViewHeight
        ])
    }
    
    private func setupIdLabel() {
        allView.addSubview(idLabel)
        NSLayoutConstraint.activate([
            idLabel.topAnchor.constraint(equalTo: allView.topAnchor, constant: 40),
            idLabel.leadingAnchor.constraint(equalTo: allView.leadingAnchor, constant: 44)
        ])
    }
    
    private func setupIdTextField() {
        allView.addSubview(idTextField)
        NSLayoutConstraint.activate([
            idTextField.topAnchor.constraint(equalTo: idLabel.bottomAnchor, constant: 8),
            idTextField.leadingAnchor.constraint(equalTo: allView.leadingAnchor, constant: 40),
            idTextField.heightAnchor.constraint(equalToConstant: 30)])
    }
    
    private func setupCheckIdOverlapBtn() {
        allView.addSubview(checkIdOverlapBtn)
        NSLayoutConstraint.activate([
            checkIdOverlapBtn.topAnchor.constraint(equalTo: idTextField.topAnchor),
            checkIdOverlapBtn.leadingAnchor.constraint(equalTo: idTextField.trailingAnchor, constant: 13),
            checkIdOverlapBtn.trailingAnchor.constraint(equalTo: allView.trailingAnchor, constant: -42),
            checkIdOverlapBtn.widthAnchor.constraint(equalToConstant: 58)])
    }
    
    private func setupIdOverlapResultLabel() {
        allView.addSubview(idOverlapResultLabel)
        NSLayoutConstraint.activate([
            idOverlapResultLabel.topAnchor.constraint(equalTo: idTextField.bottomAnchor, constant: 6),
            idOverlapResultLabel.leadingAnchor.constraint(equalTo: allView.leadingAnchor, constant: 44)        ])
    }
    
    private func setupPwdLabel() {
        allView.addSubview(pwdLabel)
        NSLayoutConstraint.activate([
            pwdLabel.topAnchor.constraint(equalTo: idOverlapResultLabel.bottomAnchor, constant: 18),
            pwdLabel.leadingAnchor.constraint(equalTo: allView.leadingAnchor, constant: 44)        ])
    }
    
    private func setupPwdTextField() {
        allView.addSubview(pwdTextField)
        NSLayoutConstraint.activate([
            pwdTextField.topAnchor.constraint(equalTo: pwdLabel.bottomAnchor, constant: 8),
            pwdTextField.leadingAnchor.constraint(equalTo: allView.leadingAnchor, constant: 40),
            pwdTextField.trailingAnchor.constraint(equalTo: allView.trailingAnchor, constant: -42),
            pwdTextField.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func setupCheckPwdLabel() {
        allView.addSubview(checkPwdLabel)
        NSLayoutConstraint.activate([
            checkPwdLabel.topAnchor.constraint(equalTo: pwdTextField.bottomAnchor, constant: 39),
            checkPwdLabel.leadingAnchor.constraint(equalTo: allView.leadingAnchor, constant: 44)        ])
    }
    
    private func setupCheckPWdTextField() {
        allView.addSubview(checkPwdTextField)
        NSLayoutConstraint.activate([
            checkPwdTextField.topAnchor.constraint(equalTo: checkPwdLabel.bottomAnchor, constant: 8),
            checkPwdTextField.leadingAnchor.constraint(equalTo: allView.leadingAnchor, constant: 40),
            checkPwdTextField.trailingAnchor.constraint(equalTo: allView.trailingAnchor, constant: -42),
            checkPwdTextField.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func setupPwdSameResultLabel() {
        allView.addSubview(pwdSameResultLabel)
        NSLayoutConstraint.activate([
            pwdSameResultLabel.topAnchor.constraint(equalTo: checkPwdTextField.bottomAnchor, constant: 6),
            pwdSameResultLabel.leadingAnchor.constraint(equalTo: allView.leadingAnchor, constant: 44)
        ])
    }
    
    private func setupNameLabel() {
        allView.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: pwdSameResultLabel.bottomAnchor, constant: 14),
            nameLabel.leadingAnchor.constraint(equalTo: allView.leadingAnchor, constant: 40)
        ])
    }
    
    private func setupNameTextField() {
        allView.addSubview(nameTextField)
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            nameTextField.leadingAnchor.constraint(equalTo: allView.leadingAnchor, constant: 40),
            nameTextField.widthAnchor.constraint(equalToConstant: 90),
            nameTextField.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func setupPhoneNumberLabel() {
        allView.addSubview(phoneNumberLabel)
        NSLayoutConstraint.activate([
            phoneNumberLabel.topAnchor.constraint(equalTo: nameLabel.topAnchor),
            phoneNumberLabel.leadingAnchor.constraint(equalTo: nameTextField.trailingAnchor, constant: 19)
        ])
    }
    
    private func setupPhoneNumbeTextField() {
        allView.addSubview(phoneNumberTextField)
        NSLayoutConstraint.activate([
            phoneNumberTextField.topAnchor.constraint(equalTo: phoneNumberLabel.bottomAnchor, constant: 8),
            phoneNumberTextField.leadingAnchor.constraint(equalTo: nameTextField.trailingAnchor, constant: 19),
            phoneNumberTextField.trailingAnchor.constraint(equalTo: allView.trailingAnchor, constant: -41),
            phoneNumberTextField.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func setupDormitoryLabel() {
        allView.addSubview(dormitoryLabel)
        NSLayoutConstraint.activate([
            dormitoryLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 39),
            dormitoryLabel.leadingAnchor.constraint(equalTo: allView.leadingAnchor, constant: 40)
        ])
    }
    
    private func setupDormitoryView() {
        allView.addSubview(dormitoryView)
        NSLayoutConstraint.activate([
            dormitoryView.topAnchor.constraint(equalTo: dormitoryLabel.bottomAnchor, constant: 8),
            dormitoryView.leadingAnchor.constraint(equalTo: allView.leadingAnchor, constant: 40),
            dormitoryView.widthAnchor.constraint(equalToConstant: 130),
            dormitoryView.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func setupDormitoryNameLabel() {
        dormitoryView.addSubview(dormitoryNameLabel)
        NSLayoutConstraint.activate([
            dormitoryNameLabel.centerYAnchor.constraint(equalTo: dormitoryView.centerYAnchor),
            dormitoryNameLabel.leadingAnchor.constraint(equalTo: dormitoryView.leadingAnchor, constant: 8)
        ])
    }
    
    private func setupDropDownBtn() {
        dormitoryView.addSubview(dropDownBtn)
        NSLayoutConstraint.activate([
            dropDownBtn.centerYAnchor.constraint(equalTo: dormitoryView.centerYAnchor),
            dropDownBtn.trailingAnchor.constraint(equalTo: dormitoryView.trailingAnchor, constant: -10)
        ])
    }
    
    private func setupRoomLabel() {
        allView.addSubview(roomLabel)
        NSLayoutConstraint.activate([
            roomLabel.topAnchor.constraint(equalTo: dormitoryLabel.topAnchor),
            roomLabel.leadingAnchor.constraint(equalTo: dormitoryView.trailingAnchor, constant: 18)
        ])
    }
    
    private func setupRoomTextField() {
        allView.addSubview(roomTextField)
        NSLayoutConstraint.activate([
            roomTextField.topAnchor.constraint(equalTo: roomLabel.bottomAnchor, constant: 8),
            roomTextField.leadingAnchor.constraint(equalTo: dormitoryView.trailingAnchor, constant: 18),
            roomTextField.trailingAnchor.constraint(equalTo: allView.trailingAnchor, constant: -41),
            roomTextField.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func setupAgreeTermsLabel() {
        allView.addSubview(agreeTermsLabel)
        NSLayoutConstraint.activate([
            agreeTermsLabel.topAnchor.constraint(equalTo: dormitoryView.bottomAnchor, constant: 64),
            agreeTermsLabel.leadingAnchor.constraint(equalTo: allView.leadingAnchor, constant: 40)
        ])
    }
    
    private func setupAgreeAllTermsView() {
        allView.addSubview(agreeAllTermsView)
        NSLayoutConstraint.activate([
            agreeAllTermsView.topAnchor.constraint(equalTo: agreeTermsLabel.bottomAnchor, constant: 16),
            agreeAllTermsView.leadingAnchor.constraint(equalTo: allView.leadingAnchor, constant: 42),
            agreeAllTermsView.trailingAnchor.constraint(equalTo: allView.trailingAnchor, constant: -42),
            agreeAllTermsView.heightAnchor.constraint(equalToConstant: 34)
        ])
    }
    
    private func setupCheckAllTermsBtn() {
        agreeAllTermsView.addSubview(checkAllTermsBtn)
        NSLayoutConstraint.activate([
            checkAllTermsBtn.centerYAnchor.constraint(equalTo: agreeAllTermsView.centerYAnchor),
            checkAllTermsBtn.leadingAnchor.constraint(equalTo: agreeAllTermsView.leadingAnchor, constant: 9),
            checkAllTermsBtn.widthAnchor.constraint(equalToConstant: 17)
        ])
    }
    
    private func setupAgreeAllTermsLabel() {
        agreeAllTermsView.addSubview(agreeAllTermsLabel)
        NSLayoutConstraint.activate([
            agreeAllTermsLabel.centerYAnchor.constraint(equalTo: agreeAllTermsView.centerYAnchor),
            agreeAllTermsLabel.leadingAnchor.constraint(equalTo: checkAllTermsBtn.trailingAnchor, constant: 9)
        ])
    }
    
    private func setupCheckTerm1Btn() {
        allView.addSubview(checkTerm1Btn)
        NSLayoutConstraint.activate([
            checkTerm1Btn.topAnchor.constraint(equalTo: agreeAllTermsView.bottomAnchor, constant: 29),
            checkTerm1Btn.leadingAnchor.constraint(equalTo: allView.leadingAnchor, constant: 44),
            checkTerm1Btn.widthAnchor.constraint(equalToConstant: 17)
        ])
    }
    
    private func setupTerm1Label() {
        allView.addSubview(term1Label)
        NSLayoutConstraint.activate([
            term1Label.centerYAnchor.constraint(equalTo: checkTerm1Btn.centerYAnchor),
            term1Label.leadingAnchor.constraint(equalTo: checkTerm1Btn.trailingAnchor, constant: 14)
        ])
    }
    
    private func setupTerm1EssentialLabel() {
        allView.addSubview(term1EssentialLabel)
        NSLayoutConstraint.activate([
            term1EssentialLabel.centerYAnchor.constraint(equalTo: checkTerm1Btn.centerYAnchor),
            term1EssentialLabel.leadingAnchor.constraint(equalTo: term1Label.trailingAnchor, constant: 3)
        ])
    }
    
    private func setupTerm1ViewMoreBtn() {
        allView.addSubview(term1ViewMoreBtn)
        NSLayoutConstraint.activate([
            term1ViewMoreBtn.centerYAnchor.constraint(equalTo: checkTerm1Btn.centerYAnchor),
            term1ViewMoreBtn.trailingAnchor.constraint(equalTo: allView.trailingAnchor, constant: -41)
        ])
    }
    
    private func setupCheckTerm2Btn() {
        allView.addSubview(checkTerm2Btn)
        NSLayoutConstraint.activate([
            checkTerm2Btn.topAnchor.constraint(equalTo: term1ContentScrollView.bottomAnchor, constant: 16),
            checkTerm2Btn.leadingAnchor.constraint(equalTo: allView.leadingAnchor, constant: 44),
            checkTerm2Btn.widthAnchor.constraint(equalToConstant: 17)
        ])
    }
    
    private func setupTerm2Label() {
        allView.addSubview(term2Label)
        NSLayoutConstraint.activate([
            term2Label.centerYAnchor.constraint(equalTo: checkTerm2Btn.centerYAnchor),
            term2Label.leadingAnchor.constraint(equalTo: checkTerm2Btn.trailingAnchor, constant: 14)
        ])
    }
    
    private func setupTerm2EssentialLabel() {
        allView.addSubview(term2EssentialLabel)
        NSLayoutConstraint.activate([
            term2EssentialLabel.centerYAnchor.constraint(equalTo: checkTerm2Btn.centerYAnchor),
            term2EssentialLabel.leadingAnchor.constraint(equalTo: term2Label.trailingAnchor, constant: 3)
        ])
    }
    
    private func setupTerm2ViewMoreBtn() {
        allView.addSubview(term2ViewMoreBtn)
        NSLayoutConstraint.activate([
            term2ViewMoreBtn.centerYAnchor.constraint(equalTo: checkTerm2Btn.centerYAnchor),
            term2ViewMoreBtn.trailingAnchor.constraint(equalTo: allView.trailingAnchor, constant: -41)
        ])
    }
    
    private func setupRegisterBtn() {
        allView.addSubview(registerBtn)
        NSLayoutConstraint.activate([
            registerBtn.topAnchor.constraint(equalTo: term2ContentScrollView.bottomAnchor, constant: 60),
            registerBtn.leadingAnchor.constraint(equalTo: allView.leadingAnchor, constant: 107),
            registerBtn.trailingAnchor.constraint(equalTo: allView.trailingAnchor, constant: -107),
            registerBtn.bottomAnchor.constraint(equalTo: allView.bottomAnchor, constant: -50),
            registerBtn.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupTerm1ScrollView() {
        allView.addSubview(term1ContentScrollView)
        NSLayoutConstraint.activate([
            term1ContentScrollView.topAnchor.constraint(equalTo: checkTerm1Btn.bottomAnchor, constant: 16),
            term1ContentScrollView.leadingAnchor.constraint(equalTo: checkTerm1Btn.leadingAnchor),
            term1ContentScrollView.trailingAnchor.constraint(equalTo: allView.trailingAnchor, constant: -40),
            term1ContentScrollView.heightAnchor.constraint(equalToConstant: 162)
        ])
    }
    
    private func setupTerm1ContentView() {
        term1ContentScrollView.addSubview(term1ContentView)
        NSLayoutConstraint.activate([
            term1ContentView.topAnchor.constraint(equalTo: term1ContentScrollView.topAnchor),
            term1ContentView.leadingAnchor.constraint(equalTo: term1ContentScrollView.leadingAnchor),
            term1ContentView.trailingAnchor.constraint(equalTo: term1ContentScrollView.trailingAnchor),
            term1ContentView.bottomAnchor.constraint(equalTo: term1ContentScrollView.bottomAnchor)
        ])
        
        let contentViewCenterY = term1ContentView.centerYAnchor.constraint(equalTo: term1ContentScrollView.centerYAnchor)
        contentViewCenterY.priority = .defaultLow
        
        let contentViewHeight = term1ContentView.heightAnchor.constraint(greaterThanOrEqualTo: self.heightAnchor)
        contentViewHeight.priority = .defaultLow
        
        NSLayoutConstraint.activate([
            term1ContentView.centerXAnchor.constraint(equalTo: term1ContentScrollView.centerXAnchor),
            contentViewCenterY,
            contentViewHeight
        ])
    }
    
    private func setupTerm1ContentLabel() {
        term1ContentView.addSubview(term1ContentLabel)
        NSLayoutConstraint.activate([
            term1ContentLabel.topAnchor.constraint(equalTo: term1ContentView.topAnchor, constant: 10),
            term1ContentLabel.leadingAnchor.constraint(equalTo: term1ContentView.leadingAnchor, constant: 10),
            term1ContentLabel.trailingAnchor.constraint(equalTo: term1ContentView.trailingAnchor, constant: -10),
            term1ContentLabel.bottomAnchor.constraint(equalTo: term1ContentView.bottomAnchor, constant: 10)
        ])
    }
    
    private func setupTerm2ScrollView() {
        allView.addSubview(term2ContentScrollView)
        NSLayoutConstraint.activate([
            term2ContentScrollView.topAnchor.constraint(equalTo: checkTerm2Btn.bottomAnchor, constant: 16),
            term2ContentScrollView.leadingAnchor.constraint(equalTo: checkTerm2Btn.leadingAnchor),
            term2ContentScrollView.trailingAnchor.constraint(equalTo: allView.trailingAnchor, constant: -40),
            term2ContentScrollView.heightAnchor.constraint(equalToConstant: 162)
        ])
    }
    
    private func setupTerm2ContentView() {
        term2ContentScrollView.addSubview(term2ContentView)
        NSLayoutConstraint.activate([
            term2ContentView.topAnchor.constraint(equalTo: term2ContentScrollView.topAnchor),
            term2ContentView.leadingAnchor.constraint(equalTo: term2ContentScrollView.leadingAnchor),
            term2ContentView.trailingAnchor.constraint(equalTo: term2ContentScrollView.trailingAnchor),
            term2ContentView.bottomAnchor.constraint(equalTo: term2ContentScrollView.bottomAnchor)
        ])
        
        let contentViewCenterY = term2ContentView.centerYAnchor.constraint(equalTo: term2ContentScrollView.centerYAnchor)
        contentViewCenterY.priority = .defaultLow
        
        let contentViewHeight = term2ContentView.heightAnchor.constraint(greaterThanOrEqualTo: self.heightAnchor)
        contentViewHeight.priority = .defaultLow
        
        NSLayoutConstraint.activate([
            term2ContentView.centerXAnchor.constraint(equalTo: term2ContentScrollView.centerXAnchor),
            contentViewCenterY,
            contentViewHeight
        ])
    }
    
    private func setupTerm2ContentLabel() {
        term2ContentView.addSubview(term2ContentLabel)
        NSLayoutConstraint.activate([
            term2ContentLabel.topAnchor.constraint(equalTo: term2ContentView.topAnchor, constant: 10),
            term2ContentLabel.leadingAnchor.constraint(equalTo: term2ContentView.leadingAnchor, constant: 10),
            term2ContentLabel.trailingAnchor.constraint(equalTo: term2ContentView.trailingAnchor, constant: -10),
            term2ContentLabel.bottomAnchor.constraint(equalTo: term2ContentView.bottomAnchor, constant: 10)
        ])
    }
    
    @objc func popVC() {
        popVCHandler?()
    }
    
    @objc func checkIdOverlap() {
        if let id = idTextField.text {
            AF.request(
                "\(API.shared.base_url)/common/isAvailableId?id=\(id)",
                method: .get,
                encoding: JSONEncoding.default,
                headers: ["Accept": "text/plain"]
            )
            .responseString { response in
                if response.response?.statusCode == 200 {
                    if let value = response.value {
                        switch value {
                        case "true":
                            self.idOverlapResultLabel.text = "사용 가능한 아이디입니다."
                            self.idOverlapResultLabel.textColor = .primary
                            
                        case "false":
                            self.idOverlapResultLabel.text = "이미 존재하는 아이디입니다."
                            self.idOverlapResultLabel.textColor = UIColor(hexString: "FF0000")
                            
                        default:
                            return
                        }
                    }
                }
                else {
                    print("error: \(response.error)")
                }
            }
        }
    }
    
    @objc final private func checkPwdTextFieldValueChanged(textField: UITextField) {
        if checkPwdTextField.text != pwdTextField.text {
            pwdSameResultLabel.text = "비밀번호가 다릅니다."
        }
        else {
            pwdSameResultLabel.text = ""
        }
    }
    
    @objc func dormitoryDropDownBtnSelected(_ sender: Any) {
        isdropdownBtnClicked = !isdropdownBtnClicked
        dropDownBtn.setImage(isdropdownBtnClicked ? UIImage(systemName: "arrowtriangle.up.fill") : UIImage(systemName: "arrowtriangle.down.fill"), for: .normal)
        dropdown.show()
    }
    
    @objc func term1IsAgree() {
        term1AgreeBtnClicked = !term1AgreeBtnClicked
        changeTermColor(1)
    }
    
    @objc func term2IsAgree() {
        term2AgreeBtnClicked = !term2AgreeBtnClicked
        changeTermColor(2)
    }
    
    @objc func changeTermColor(_ idx: Int) {
        if idx == 1 {
            if term1AgreeBtnClicked {
                checkTerm1Btn.tintColor = .primary
                term1Label.textColor = .primary
                term1EssentialLabel.textColor = .primary
            }
            else {
                checkTerm1Btn.tintColor = .textField_gray
                term1Label.textColor = UIColor(hexString: "818181")
                term1EssentialLabel.textColor = .pdark
            }
        }
        else {
            if term2AgreeBtnClicked {
                checkTerm2Btn.tintColor = .primary
                term2Label.textColor = .primary
                term2EssentialLabel.textColor = .primary
            }
            else {
                checkTerm2Btn.tintColor = .textField_gray
                term2Label.textColor = UIColor(hexString: "818181")
                term2EssentialLabel.textColor = .pdark
            }
        }
    }
    
    @objc func termAllAgree() {
        allTermAgreeBtnClicked = !allTermAgreeBtnClicked
        if allTermAgreeBtnClicked {
            checkAllTermsBtn.tintColor = .primary
            agreeAllTermsLabel.textColor = .primary
            agreeAllTermsView.layer.borderColor = UIColor.primary.cgColor
            
            term1AgreeBtnClicked = true
            term2AgreeBtnClicked = true
            changeTermColor(1)
            changeTermColor(2)
            print(allTermAgreeBtnClicked)
            print(term1AgreeBtnClicked)
            print(term2AgreeBtnClicked)
        }
        else {
            checkAllTermsBtn.tintColor = .textField_gray
            agreeAllTermsLabel.textColor = UIColor(hexString: "818181")
            agreeAllTermsView.layer.borderColor = UIColor.textField_gray.cgColor
            
            term1AgreeBtnClicked = false
            term2AgreeBtnClicked = false
            changeTermColor(1)
            changeTermColor(2)
            print(allTermAgreeBtnClicked)
            print(term1AgreeBtnClicked)
            print(term2AgreeBtnClicked)
        }
    }
}

extension RegisterView {
    func setDropDown() {
        dropdown.dataSource = menuList
        dropdown.anchorView = self.dormitoryView
        dropdown.bottomOffset = CGPoint(x: 0, y: dormitoryView.bounds.height)
        dropdown.selectionAction = { [weak self] (index, item) in
            self!.dormitoryNameLabel.text = item
            self!.isdropdownBtnClicked = !self!.isdropdownBtnClicked
            self!.dropDownBtn.setImage(self!.isdropdownBtnClicked ? UIImage(systemName: "arrowtriangle.up.fill") : UIImage(systemName: "arrowtriangle.down.fill"), for: .normal)
        }
        
        dropdown.cancelAction = { [weak self] in
            self!.isdropdownBtnClicked = !self!.isdropdownBtnClicked
            self!.dropDownBtn.setImage(self!.isdropdownBtnClicked ? UIImage(systemName: "arrowtriangle.up.fill") : UIImage(systemName: "arrowtriangle.down.fill"), for: .normal)
        }
    }
}

extension RegisterView {
    func readTextFile(filename: String) -> String {
        var result = ""

        guard let pahts = Bundle.main.path(forResource: filename, ofType: nil) else { return "" }
        do {
            result = try String(contentsOfFile: pahts, encoding: .utf8)
            return result
        } catch {
            return "Error: file read failed - \(error.localizedDescription)"
        }
    }
}
