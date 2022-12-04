//
//  CommunityManager.swift
//  SujungVillage-User
//
//  Created by 홍세은 on 2022/12/04.
//

import Foundation

class CommunityManager {
    static let shared = CommunityManager()
    
    func addComment(commentModel: WriteCommentModel, completion: @escaping (Bool)->Void) {
        Repository.shared.writeComment(writeModel: commentModel) { status, response in
            switch status {
            case .ok:
                print("댓글 등록 성공")
                completion(true)
            default:
                print("댓글 등록 실패: \(status)")
                completion(false)
            }
        }
    }
    
    func deleteComment(commentId: Int, completion: @escaping (Bool)->Void) {
        Repository.shared.deleteComment(commentId: commentId) { status, result in
            if result == "댓글 삭제 완료" {
                print("댓글 삭제 완료")
                completion(true)
            }
            else {
                print("댓글 삭제 실패: \(status)")
                completion(false)
            }
        }
    }
}
