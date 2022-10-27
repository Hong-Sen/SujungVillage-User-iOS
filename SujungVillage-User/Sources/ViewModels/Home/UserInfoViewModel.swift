//
//  HomeViewModel.swift
//  SujungVillage-User
//
//  Created by 홍세은 on 2022/10/03.
//

import Foundation
import Combine

class UserInfoViewModel {
    static let shared = UserInfoViewModel()
    private init() {}
    let repository = Repository()
    var onUpdated: () -> Void = {}
    var year: Int = Calendar.current.component(.year, from: Date())
    var month: Int = Calendar.current.component(.month, from: Date())
    
    var userName: String = "???"
    {
        didSet {
            onUpdated()
        }
    }
    
    var dormitoryName: String = ""
    {
        didSet {
            onUpdated()
        }
    }
    
    var detailedAddress: String = ""
    {
        didSet {
            onUpdated()
        }
    }
    
    var plusLMP: Int = 0
    {
        didSet {
            onUpdated()
        }
    }
    
    var minusLMP: Int = 0
    {
        didSet {
            onUpdated()
        }
    }
    
    var rollcallDays: [Day] = []
    {
        didSet {
            onUpdated()
        }
    }

    var appliedRollcallDays: [Day] = []
    {
        didSet {
            onUpdated()
        }
    }

    var appliedExeatDays: [Day] = []
    {
        didSet {
            onUpdated()
        }
    }
    
    func fetchResidentInfo(year: Int, month: Int) {
        self.repository.getHomeInfo(year: year, month: month) { status, userInfoResponse in
            switch status {
            case .ok:
                if let name = userInfoResponse?.residentInfo.name,
                   let dormitory = userInfoResponse?.residentInfo.dormitoryName,
                   let detail = userInfoResponse?.residentInfo.detailedAddress,
                   let plus = userInfoResponse?.residentInfo.plusLMP,
                   let minus = userInfoResponse?.residentInfo.minusLMP,
                   let rollcallDays = userInfoResponse?.rollcallDays,
                   let appliedRollcallDays = userInfoResponse?.appliedRollcallDays,
                   let appliedExeatDays = userInfoResponse?.appliedExeatDays {
                    self.userName = name
                    self.dormitoryName = dormitory
                    self.detailedAddress = detail
                    self.plusLMP = plus
                    self.minusLMP = minus
                    self.rollcallDays = rollcallDays
                    self.appliedRollcallDays = appliedRollcallDays
                    self.appliedExeatDays = appliedExeatDays
                }
            default:
                print("home viewmodel error: \(status)")
                break
            }
        }
    }
}
