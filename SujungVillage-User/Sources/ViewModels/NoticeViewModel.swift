//
//  NoticeViewModel.swift
//  SujungVillage-User
//
//  Created by 홍세은 on 2022/10/12.
//

import Foundation

class NoticeViewModel: NSObject {
    let repository =  Repository()
     var onUpdated: () -> Void = {}
     
     var noticeTitleList: [NoticeTitleResponse] = []
     {
         didSet {
             onUpdated()
         }
     }
     
     override init() {
         super.init()
         fetchNoticeTitle()
     }
     
     func fetchNoticeTitle() {
         self.repository.getNoticeTitle(dormitoryName: UserDefaults.standard.string(forKey: "dormitoryName") ?? "전체"){ status, noticeTitleResponse in
             switch status {
             case .ok:
                 if let notices = noticeTitleResponse {
                     self.noticeTitleList = notices
                 }
                 break

             default:
                 print("error: \(status)")
                 break
             }
         }
     }
 }
