//
//  CommunityViewModel.swift
//  SujungVillage-User
//
//  Created by 홍세은 on 2022/11/24.
//

import Foundation

class CommunityViewModel {
    static let shared = CommunityViewModel()
    private init() {}
    let repository =  Repository()
     var onUpdated: () -> Void = {}
     
     var postList: [CommunityPostResponse] = []
     {
         didSet {
             onUpdated()
         }
     }
     
    func fetchCommunityPostList(dormitoryName: String) {
        self.repository.getAllPost(dormitoryName: dormitoryName) { status, allPostResponse in
            switch status {
            case .ok:
                if let posts = allPostResponse {
                    self.postList = posts
                    
                }
                break
            default:
                print("community viewmodel error: \(status)")
                break
            }
        }
    }
         
 }
