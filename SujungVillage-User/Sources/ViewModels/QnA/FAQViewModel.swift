//
//  FAQViewModel.swift
//  SujungVillage-User
//
//  Created by 홍세은 on 2022/11/01.
//

import Foundation

class FAQViewModel {
    static let shared = FAQViewModel()
    private init() {}
    var onUpdated: () -> Void = {}
    let repository = Repository()
    
    var FAQList: [FAQListResponse] = []
    {
        didSet {
            onUpdated()
        }
    }
    
    func fetchFAQs() {
        self.repository.getFAQs { status, FAQresponse in
            switch status {
            case .ok:
                if let faqs = FAQresponse {
                    self.FAQList = faqs
                }
                break
                
            default:
                print("FAQ viewmodel error: \(status)")
                break
            }
        }
    }
}
