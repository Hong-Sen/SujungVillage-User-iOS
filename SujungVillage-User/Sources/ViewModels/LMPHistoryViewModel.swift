//
//  LMPHistoryViewModel.swift
//  SujungVillage-User
//
//  Created by 홍세은 on 2022/10/09.
//

import Foundation

class LMPHistoryViewModel: NSObject {
   let repository =  Repository()
    var onUpdated: () -> Void = {}
    
    var historyArr: [History] = []
    {
        didSet {
            onUpdated()
        }
    }
    
    override init() {
        super.init()
        fetchLMPHistory()
    }
    
    func fetchLMPHistory() {
        self.repository.getLMPHistory { status, LMPHistoyResponse in
            switch status {
            case .ok:
                if let historyArr = LMPHistoyResponse?.historyList {
                    self.historyArr = historyArr
                }

            default:
                print("error: \(status)")
                break
            }
        }
    }
}
