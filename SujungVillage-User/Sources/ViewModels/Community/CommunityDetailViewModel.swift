//
//  CommunityDetailViewModel.swift
//  SujungVillage-User
//
//  Created by 홍세은 on 2022/12/03.
//

import Foundation

class CommunityDetailViewModel {
    static let shared = CommunityDetailViewModel()
    private init() {}
    let repository =  Repository()
     var onUpdated: () -> Void = {}
    
    var writerId: String = ""
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
    
    var date: String = ""
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
    
     var commentList: [CommunityComment] = []
     {
         didSet {
             onUpdated()
         }
     }
    
    func fetchCommunityDetail(postId: Int) {
        self.repository.getCommunityDetailPost(postId: postId) { status, detailResponse in
            switch status {
            case .ok:
                if let writer = detailResponse?.writerID,
                   let title = detailResponse?.title,
                   let date = detailResponse?.modDate,
                   let content = detailResponse?.content,
                   let comments = detailResponse?.comments {
                    self.writerId = writer
                    self.title = title
                    var formatTime = date.replacingOccurrences(of: "T", with: " ")
                    formatTime = formatTime.replacingOccurrences(of: "-", with: "/")
                    self.date = String(formatTime.prefix(16))
                    self.content = content
                    self.commentList = comments
                }
            default:
                print("community detail viewmodel error: \(status)")
                break
            }
        }
    }
         
 }
