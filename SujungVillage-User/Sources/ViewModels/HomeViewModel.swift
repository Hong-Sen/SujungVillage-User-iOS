//
//  HomeViewModel.swift
//  SujungVillage-User
//
//  Created by 홍세은 on 2022/10/03.
//

import Foundation

class HomeViewModel: NSObject {
   let repository =  Repository()
    var onUpdated: () -> Void = {}
    
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
    
    override init() {
        super.init()
       fetchResidentInfo(year: 2022, month: 8) // FIX: 현재 년도, 월로 변경 하기
    }
    
    func fetchResidentInfo(year: Int, month: Int) {
        self.repository.getHomeInfo(year: 2022, month: 8) { status, homeResponse in
            switch status {
            case .ok:
                if let name = homeResponse?.residentInfo.name,
                   let dormitory = homeResponse?.residentInfo.dormitoryName,
                   let plus = homeResponse?.residentInfo.plusLMP,
                   let minus = homeResponse?.residentInfo.minusLMP {
                    self.userName = name
                    self.dormitoryName = dormitory
                    self.plusLMP = plus
                    self.minusLMP = minus
                }
            default:
                print("error: \(status)")
                break
            }
        }
    }
}
