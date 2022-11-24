//
//  CommunityViewController.swift
//  SujungVillage-User
//
//  Created by 홍세은 on 2022/09/28.
//

import UIKit
import Foundation
import DropDown

class CommunityViewController: UIViewController {
    let dropdown = DropDown()
    private var isdropdownBtnClicked: Bool = false
    let menuList = ["전체", "성미관", "000", "000", "000", "000"] // FIX: Server에서 List 받기
    
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
    
    private var tableView = UITableView()
    private var postingList: [CommunityPostResponse] = []
    private let viewModel = CommunityViewModel.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchTableView()
        setUpViews()
        setDropDown()
        setTable()
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
        setUpnavigationView()
        setUpDormitorySelectionView()
        setUpDormitoryLabel()
        setUpDropDownImg()
        setUpSearchBtn()
        setUpAlarmBtn()
        setUpTableView()
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
    
    @objc func dropDownBtnSelected() {
        isdropdownBtnClicked = !isdropdownBtnClicked
        dropDownBtn.setImage(isdropdownBtnClicked ? UIImage(systemName: "chevron.up") : UIImage(systemName: "chevron.down"), for: .normal)
        dropdown.show()
    }
    
    @objc func searchBtnSelected() {
        print("SEARCH!!")
    }
    
    @objc func alarmBtnSelected() {
        print("alarm!!")
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
        return postingList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 133
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CommunityCell.cellId, for: indexPath) as! CommunityCell
        cell.titleLabel.text = postingList[indexPath.row].title
        var date = postingList[indexPath.row].regDate.substring(from: 0, to: 9)
        cell.dateLabel.text = date
        cell.contentLabel.text =  postingList[indexPath.row].content
        cell.numOfCommentsLabel.text =  String(postingList[indexPath.row].numOfComments)
        cell.selectionStyle = .none
        return cell
    }
}

