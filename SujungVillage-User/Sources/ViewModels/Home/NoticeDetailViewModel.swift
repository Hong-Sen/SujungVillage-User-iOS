//
//  NoticeDetailViewModel.swift
//  SujungVillage-User
//
//  Created by 홍세은 on 2022/10/13.
//

import Foundation

class NoticeDetailViewModel {
    static let shared = NoticeDetailViewModel()
    private init() {}
    let repository =  Repository()
    var onUpdated: () -> Void = {}
    var announcementId: Int = -101
    
    var dormitoryName: String = ""
    {
        didSet {
            onUpdated()
        }
    }
    
    var title: String = ""
    {
        didSet {
            onUpdated()
        }
    }
    
    var content: String = ""
    {
        didSet {
            onUpdated()
        }
    }
    
    func fetchNoticeDetail() {
        self.repository.getNoticeDetail(announcementId: announcementId) { status, noticeDetailResponse in
            switch status {
            case .ok:
                if let dormitoryName = noticeDetailResponse?.dormitoryName,
                   let title = noticeDetailResponse?.title,
                   let content = noticeDetailResponse?.content {
                    self.dormitoryName = dormitoryName
                    self.title = title
                    self.content = content
                }
                break
            default:
                print("error: \(status)")
                break
            }
        }
    }
}

