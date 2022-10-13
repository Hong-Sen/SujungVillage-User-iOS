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
    
    var historyList: [LMPHistoryResponse] = []
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
        self.repository.getLMPHistory { status, response in
            switch status {
            case .ok:
                if let histories = response {
                    self.historyList = histories
                }

            default:
                print("error: \(status)")
                break
            }
        }
    }
}
