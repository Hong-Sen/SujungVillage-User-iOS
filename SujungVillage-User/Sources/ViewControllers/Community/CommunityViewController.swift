//
//  CommunityViewController.swift
//  SujungVillage-User
//
//  Created by 홍세은 on 2022/09/28.
//

import UIKit
import Foundation
import DropDown
import DTZFloatingActionButton

class CommunityViewController: UIViewController, UITextFieldDelegate {
    
    private var navigationView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .primary
        view.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 30)
        return view
    }()
    
    private lazy var dormitorySelectionView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .primary
        return view
    }()
    
    private lazy var dormitoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "전체"
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private lazy var searchView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.roundCorners(corners: [.allCorners], radius: 6)
        return view
    }()
    
    private lazy var searchTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.setPadding(left: 5, right: 5)
        return tf
    }()
    
    private var dropDownBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        btn.tintColor = .white
        btn.addTarget(self, action: #selector(dropDownBtnSelected), for: .touchUpInside)
        return btn
    }()
    
    private lazy var searchBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        btn.tintColor = .white
        btn.addTarget(self, action: #selector(searchBtnSelected), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private lazy var alarmBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "icon_bell_white"), for: .normal)
        btn.tintColor = .white
        btn.addTarget(self, action: #selector(alarmBtnSelected), for: .touchUpInside)
        return btn
    }()
    
    let dropdown = DropDown()
    private var isdropdownBtnClicked: Bool = false
    private var isSearchBtnClicked: Bool = false
    let menuList = ["전체", "성미관", "000", "000", "000", "000"] // FIX: Server에서 List 받기
    private var tableView = UITableView()
    private var postingList: [CommunityPostResponse] = []
    private var searchList: [CommunityPostResponse] = []
    private let viewModel = CommunityViewModel.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchTableView()
        setUpViews()
        setDropDown()
        setTable()
        viewModel.fetchCommunityPostList(dormitoryName: dormitoryLabel.text!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchTableView()
        viewModel.fetchCommunityPostList(dormitoryName: dormitoryLabel.text!)
    }
    
    func fetchTableView() {
        viewModel.onUpdated = {[weak self] in
            DispatchQueue.main.async {
                self?.postingList = self?.viewModel.postList ?? []
                self?.tableView.reloadData()
            }
        }
    }
    
    func setUpViews() {
        self.view.backgroundColor = UIColor(hexString: "FBFBFB")
        self.searchTextField.delegate = self
        setUpnavigationView()
        setUpDormitorySelectionView()
        setUpDormitoryLabel()
        setUpDropDownImg()
        setUpSearchBtn()
        setUpAlarmBtn()
        setUpTableView()
        createWritingBtn()
        setUpSearchView()
        setUpSearchTextField()
        showDormitoryInfo()
    }
    
    private func setUpnavigationView() {
        view.addSubview(navigationView)
        NSLayoutConstraint.activate([
            navigationView.topAnchor.constraint(equalTo: view.topAnchor),
            navigationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navigationView.heightAnchor.constraint(equalToConstant: 114)
        ])
    }
    
    private func setUpDormitorySelectionView() {
        view.addSubview(dormitorySelectionView)
        NSLayoutConstraint.activate([
            dormitorySelectionView.centerXAnchor.constraint(equalTo: navigationView.centerXAnchor),
            dormitorySelectionView.bottomAnchor.constraint(equalTo: navigationView.bottomAnchor, constant: -27),
            dormitorySelectionView.widthAnchor.constraint(equalToConstant: 169),
            dormitorySelectionView.heightAnchor.constraint(equalToConstant: 27)
        ])
    }
    
    private func setUpDormitoryLabel() {
        dormitorySelectionView.addSubview(dormitoryLabel)
        NSLayoutConstraint.activate([
            dormitoryLabel.centerXAnchor.constraint(equalTo: dormitorySelectionView.centerXAnchor),
            dormitoryLabel.centerYAnchor.constraint(equalTo: dormitorySelectionView.centerYAnchor)
        ])
    }
    
    private func setUpDropDownImg() {
        dormitorySelectionView.addSubview(dropDownBtn)
        NSLayoutConstraint.activate([
            dropDownBtn.leadingAnchor.constraint(equalTo: dormitoryLabel.trailingAnchor, constant: 8),
            dropDownBtn.centerYAnchor.constraint(equalTo: dormitorySelectionView.centerYAnchor),
            dropDownBtn.widthAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    private func setUpAlarmBtn() {
        navigationView.addSubview(alarmBtn)
        NSLayoutConstraint.activate([
            alarmBtn.leadingAnchor.constraint(equalTo: searchBtn.trailingAnchor, constant: 20),
            alarmBtn.bottomAnchor.constraint(equalTo: navigationView.bottomAnchor, constant: -28),
            alarmBtn.heightAnchor.constraint(equalToConstant: 22)
        ])
    }
    
    private func setUpSearchBtn() {
        navigationView.addSubview(searchBtn)
        NSLayoutConstraint.activate([
            searchBtn.leadingAnchor.constraint(equalTo: dormitorySelectionView.trailingAnchor, constant: 12),
            searchBtn.bottomAnchor.constraint(equalTo: navigationView.bottomAnchor, constant: -28),
            searchBtn.heightAnchor.constraint(equalToConstant: 22)
        ])
    }
    
    private func setUpSearchView() {
        navigationView.addSubview(searchView)
        NSLayoutConstraint.activate([
            searchView.leadingAnchor.constraint(equalTo: navigationView.leadingAnchor, constant: 28),
            searchView.bottomAnchor.constraint(equalTo: navigationView.bottomAnchor, constant: -18),
            searchView.widthAnchor.constraint(equalToConstant: 237),
            searchView.heightAnchor.constraint(equalToConstant: 39)
        ])
    }
    
    private func setUpSearchTextField() {
        searchView.addSubview(searchTextField)
        NSLayoutConstraint.activate([
            searchTextField.centerYAnchor.constraint(equalTo: searchView.centerYAnchor),
            searchTextField.leadingAnchor.constraint(equalTo: searchView.leadingAnchor),
            searchTextField.trailingAnchor.constraint(equalTo: searchView.trailingAnchor)
        ])
    }
    
    func setUpTableView() {
        tableView.backgroundColor = UIColor(hexString: "FBFBFB")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: navigationView.bottomAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
        ])
    }
    
    private func showSearchView() {
        UIView.animate(withDuration: 0, animations: {
            self.dormitorySelectionView.alpha = 0
            self.dormitoryLabel.alpha = 0
            self.dropDownBtn.alpha = 0
            self.searchView.alpha = 1
            self.searchTextField.alpha = 1
        })
    }
    
    private func showDormitoryInfo() {
        UIView.animate(withDuration: 0, animations: {
            self.dormitorySelectionView.alpha = 1
            self.dormitoryLabel.alpha = 1
            self.dropDownBtn.alpha = 1
            self.searchView.alpha = 0
            self.searchTextField.alpha = 0
        })
        searchTextField.text = ""
    }
    
    @objc func dropDownBtnSelected() {
        isdropdownBtnClicked = !isdropdownBtnClicked
        dropDownBtn.setImage(isdropdownBtnClicked ? UIImage(systemName: "chevron.up") : UIImage(systemName: "chevron.down"), for: .normal)
        dropdown.show()
    }
    
    @objc func searchBtnSelected() {
        isSearchBtnClicked = !isSearchBtnClicked
        searchBtn.setImage(isSearchBtnClicked ? UIImage(systemName: "xmark") : UIImage(systemName: "magnifyingglass"), for: .normal)
        searchBtn.tintColor = .white
        if isSearchBtnClicked {
            showSearchView()
        }
        else {
            showDormitoryInfo()
            tableView.reloadData()
        }
    }
    
    @objc func alarmBtnSelected() {
        print("alarm!!")
    }
    
    private func createWritingBtn() {
        let writingBtn = DTZFloatingActionButton(frame:CGRect(x: view.frame.size.width - 56 - 16, y: view.frame.size.height - 56 - 16 - 130, width: 56, height: 56))
        writingBtn.handler = {
            button in
            self.presentWritingView()
        }
        writingBtn.isScrollView = true
        writingBtn.buttonImage = UIImage(named: "icon_write_post")
        writingBtn.shadowCircleColor = .black
        writingBtn.shadowCircleOffSet = CGSize(width: 0, height: 2)
        writingBtn.shadowCircleOpacity = 0.2
        writingBtn.shadowCircleRadius = 2
        writingBtn.isAddShadow = true
        writingBtn.buttonColor = .primary
        self.view.addSubview(writingBtn)
    }
    
    private func presentWritingView() {
        guard let writeVC = self.storyboard?.instantiateViewController(withIdentifier: "CommunityWritingViewController") as? CommunityWritingViewController else { return }
        self.navigationController?.pushViewController(writeVC, animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if isSearchBtnClicked {
            if let keyword = searchTextField.text {
                searchList = postingList.filter{$0.title.contains(keyword) || $0.content.contains(keyword)}
                tableView.reloadData()
            }
        }
        else {
            textField.resignFirstResponder()
        }
        return true
    }
    
}

extension CommunityViewController {
    func setDropDown() {
        dropdown.dataSource = menuList
        dropdown.anchorView = self.dormitorySelectionView
        dropdown.bottomOffset = CGPoint(x: 0, y: dormitorySelectionView.bounds.height)
        dropdown.selectionAction = { [weak self] (index, item) in
            self!.dormitoryLabel.text = item
            self!.isdropdownBtnClicked = !self!.isdropdownBtnClicked
            self!.dropDownBtn.setImage(self!.isdropdownBtnClicked ? UIImage(systemName: "chevron.up") : UIImage(systemName: "chevron.down"), for: .normal)
            self!.viewModel.fetchCommunityPostList(dormitoryName: item)
        }
        
        dropdown.backgroundColor = .primary
        dropdown.textColor = .white
        dropdown.textFont = UIFont.suit(size: 22, family: .Medium)
        dropdown.selectionBackgroundColor = .plight
        dropdown.customCellConfiguration = {(index, item, cell) in
            cell.optionLabel.textAlignment = .center
            cell.layer.borderWidth = 1
            cell.layer.borderColor = UIColor.white.cgColor
        }
        
        dropdown.cancelAction = { [weak self] in
            self!.isdropdownBtnClicked = !self!.isdropdownBtnClicked
            self!.dropDownBtn.setImage(self!.isdropdownBtnClicked ? UIImage(systemName: "chevron.up") : UIImage(systemName: "chevron.down"), for: .normal)
        }
    }
}

extension CommunityViewController:UITableViewDelegate, UITableViewDataSource {
    func setTable() {
        tableView.register(CommunityCell.classForCoder(), forCellReuseIdentifier: CommunityCell.cellId)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearchBtnClicked {
            return searchList.count
        }
        return postingList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 133
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CommunityCell.cellId, for: indexPath) as! CommunityCell
        
        if isSearchBtnClicked {
            cell.titleLabel.text = searchList[indexPath.row].title
            let date = searchList[indexPath.row].regDate.substring(from: 0, to: 9)
            cell.dateLabel.text = date
            cell.contentLabel.text =  searchList[indexPath.row].content
            cell.numOfCommentsLabel.text =  String(searchList[indexPath.row].numOfComments)
        }
        else {
            cell.titleLabel.text = postingList[indexPath.row].title
            let date = postingList[indexPath.row].regDate.substring(from: 0, to: 9)
            cell.dateLabel.text = date
            cell.contentLabel.text =  postingList[indexPath.row].content
            cell.numOfCommentsLabel.text =  String(postingList[indexPath.row].numOfComments)
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = CommunityDetailViewController()
        if isSearchBtnClicked {
            detailVC.postId = searchList[indexPath.row].id
        }
        else {
            detailVC.postId = postingList[indexPath.row].id
        }
        if let dormitory = self.dormitoryLabel.text {
            detailVC.dormitoryName = "\(dormitory) 게시판"
        }
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}
