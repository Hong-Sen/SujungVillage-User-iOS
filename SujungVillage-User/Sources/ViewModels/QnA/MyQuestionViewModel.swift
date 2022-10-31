//
//  MyQuestionViewModel.swift
//  SujungVillage-User
//
//  Created by 홍세은 on 2022/10/30.
//

import Foundation

class MyQuestionViewModel {
    static let shared = MyQuestionViewModel()
    private init() {}
    var onUpdated: () -> Void = {}
    let repository = Repository()
    
    var myQList: [MyQTitleResponse] = []
    {
        didSet {
            onUpdated()
        }
    }
    
    func fetchMyQuestions() {
        self.repository.getMyQnas() { status, myQresponse in
            switch status {
            case .ok:
                if let myQs = myQresponse {
                    self.myQList = myQs
                }
                break
                
            default:
                print("my question viewmodel error: \(status)")
                break
            }
        }
    }
}

class MyQuestionDetailViewModel {
    static let shared = MyQuestionDetailViewModel()
    private init() {}
    let repository = Repository()
    var onUpdated: () -> Void = {}
    
    var title: String = "???"
    {
        didSet {
            onUpdated()
        }
    }
    
    var qDate: String = ""
    {
        didSet {
            onUpdated()
        }
    }
    
    var writerName: String = ""
    {
        didSet {
            onUpdated()
        }
    }
    
    var questionContent: String = ""
    {
        didSet {
            onUpdated()
        }
    }
    
    var aDate: String = ""
    {
        didSet {
            onUpdated()
        }
    }
    
    var answerContent: String = ""
    {
        didSet {
            onUpdated()
        }
    }
    
    func fetchMyQuestionDetail(id: Int) {
        self.repository.getQnaDetails(questionId: id) { status, myQDetailResponse in
            switch status {
            case .ok:
                if let title = myQDetailResponse?.question.title,
                   let qDate = myQDetailResponse?.question.reqDate,
                   let writerName = myQDetailResponse?.question.writerName,
                   let qContent = myQDetailResponse?.question.content {
                    self.title = title
                    //"2022-08-11T19:29:47.782682" -> 2022/07/14  10:22
                    var formatTime = qDate.replacingOccurrences(of: "T", with: " ")
                    formatTime = formatTime.replacingOccurrences(of: "-", with: "/")
                    self.qDate = String(formatTime.prefix(16))
                    self.writerName = "작성자: \(writerName)"
                    self.questionContent = qContent
                }
                if myQDetailResponse?.answer != nil {
                    if let aDate = myQDetailResponse?.answer?.regDate,
                       let aContent = myQDetailResponse?.answer?.content {
                        //"2022-08-11T19:29:47.782682" -> 2022/07/14  10:22
                        var formatTime = aDate.replacingOccurrences(of: "T", with: " ")
                        formatTime = formatTime.replacingOccurrences(of: "-", with: "/")
                        self.aDate = String(formatTime.prefix(16))
                        self.aDate = aDate
                        self.answerContent = aContent
                    }
                }
                break
                
            default:
                print("myQ detail viewmodel error: \(status)")
                break
            }
        }
    }
}
