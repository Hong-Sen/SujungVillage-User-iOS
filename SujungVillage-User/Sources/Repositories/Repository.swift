//
//  Repository.swift
//  SujungVillage-User
//
//  Created by 홍세은 on 2022/10/01.
//

import Foundation
import Alamofire

class Repository: NSObject {
    static let shared = Repository()
    private let baseUrl = API.shared.base_url
}

// MARK: Auth
extension Repository {
    func doLogin(id: String, pwd: String, fcmToken: String, completion: @escaping (HTTPStatusCode, LoginResponse?)->Void) {
        AF.request(
            "\(baseUrl)/student/login",
            method: .post,
            parameters: ["id": id,
                         "password": pwd,
                         "fcm_token": fcmToken],
            encoding: JSONEncoding.default
        )
        .responseDecodable(of: LoginResponse.self) { response in
            if let statusCode = response.response?.statusCode {
                completion(HTTPStatusCode.init(rawValue: statusCode), response.value)
            }
        }
    }
    
    func signUp(signUpModel: SignUpModel, completion: @escaping (HTTPStatusCode, _ result: String)->Void) {
        AF.request(
            "\(baseUrl)/student/signup",
            method: .post,
            parameters: ["id": signUpModel.id,
                         "password": signUpModel.password,
                         "name": signUpModel.name,
                         "dormitoryName": signUpModel.dormitoryName,
                         "detailedAddress": signUpModel.detailedAddress,
                         "phoneNumber": signUpModel.phoneNumber],
            encoding: JSONEncoding.default,
            headers: ["Content-Type": "application/json"]
        )
        .responseString { response in
            if let statusCode = response.response?.statusCode, let result = response.value {
                completion(HTTPStatusCode.init(rawValue: statusCode), result)
            }
        }
    }
}

// MARK: Home
extension Repository {
    func getHomeInfo(year: Int, month: Int, completion: @escaping (HTTPStatusCode, HomeResponse?)->Void) {
        AF.request(
            "\(baseUrl)/student/home/getInfo?year=\(year)&month=\(month)",
            method: .get,
            encoding: JSONEncoding.default,
            headers: API.shared.getAcceptHeaders()
        )
        .responseDecodable(of: HomeResponse.self) { response in
            if let statusCode = response.response?.statusCode {
                completion(HTTPStatusCode.init(rawValue: statusCode), response.value)
            }
        }
    }
}


// MARK: RollCall
extension Repository {
    func applyRollCall(image: [Int8], location: String, completion: @escaping (HTTPStatusCode, CreateRollCallResponse?)->Void) {
        AF.request(
            "\(baseUrl)/student/rollcall/applyRollcall",
            method: .post,
            parameters: ["image":image, "location": location],
            encoding: JSONEncoding.default,
            headers: API.shared.getContentTypeHeaders()
        )
        .responseDecodable(of: CreateRollCallResponse.self) { response in
            if let statusCode = response.response?.statusCode {
                completion(HTTPStatusCode.init(rawValue: statusCode), response.value)
            }
        }
    }
    
    func getRollCallInfo(rollcallId: Int, completion: @escaping (HTTPStatusCode, GetRollCallInfoResponse?)->Void) {
        AF.request(
            "\(baseUrl)/common/rollcall/getAppliedRollcallInfo?rollcallId=\(rollcallId)",
            method: .get,
            encoding: JSONEncoding.default,
            headers: API.shared.getAcceptHeaders()
        )
        .responseDecodable(of: GetRollCallInfoResponse.self) { response in
            if let statusCode = response.response?.statusCode {
                completion(HTTPStatusCode.init(rawValue: statusCode), response.value)
            }
        }
    }
}


// MARK: Exeat
extension Repository {
    func applyExeat(applyModel: ApplyExeatModel, completion: @escaping (HTTPStatusCode)->Void) {
        AF.request(
            "\(baseUrl)/student/exeat/applyExeat",
            method: .post,
            parameters: ["destination": applyModel.destination,
                         "reason": applyModel.reason,
                         "emergencyPhoneNumber": applyModel.emergencyPhoneNumber,
                         "dateToStart": applyModel.dateToStart,
                         "dateToEnd": applyModel.dateToEnd],
            encoding: JSONEncoding.default,
            headers: API.shared.getContentTypeHeaders()
        )
        .responseDecodable(of: GetAppliedExeatResponse.self) { response in
            if let statusCode = response.response?.statusCode {
                completion(HTTPStatusCode.init(rawValue: statusCode))
            }
        }
    }
    
    func applyLongTermExeat(applyModel: ApplyLongTermExeatModel, completion: @escaping (HTTPStatusCode)->Void) {
        AF.request(
            "\(baseUrl)/student/exeat/applyLongTermExeat",
            method: .post,
            parameters: ["destination": applyModel.destination,
                         "reason": applyModel.reason,
                         "emergencyPhoneNumber": applyModel.emergencyPhoneNumber,
                         "startDate": applyModel.startDate,
                         "endDate": applyModel.endDate],
            encoding: JSONEncoding.default,
            headers: API.shared.getContentTypeHeaders()
        )
        .responseDecodable(of: GetAppliedLongTermExeatResponse.self) { response in
            if let statusCode = response.response?.statusCode {
                completion(HTTPStatusCode.init(rawValue: statusCode))
            }
        }
    }
    
    func getAppliedExeat(exeatId: Int, completion: @escaping (HTTPStatusCode, GetAppliedExeatResponse?)->Void) {
        AF.request(
            "\(baseUrl)/student/exeat/getAppliedExeat?exeatId=\(exeatId)",
            method: .get,
            encoding: JSONEncoding.default,
            headers: API.shared.getAcceptHeaders()
        )
        .responseDecodable(of: GetAppliedExeatResponse.self) { response in
            if let statusCode = response.response?.statusCode {
                completion(HTTPStatusCode.init(rawValue: statusCode), response.value)
            }
        }
    }
    
    func getAppliedLongTermExeat(exeatId: Int, completion: @escaping (HTTPStatusCode, GetAppliedLongTermExeatResponse?)->Void) {
        AF.request(
            "\(baseUrl)/student/exeat/getApplieLongTermExeat?exeatId=\(exeatId)",
            method: .get,
            encoding: JSONEncoding.default,
            headers: API.shared.getContentTypeHeaders()
        )
        .responseDecodable(of: GetAppliedLongTermExeatResponse.self) { response in
            if let statusCode = response.response?.statusCode {
                completion(HTTPStatusCode.init(rawValue: statusCode), response.value)
            }
        }
    }
    
    func cancleExeat(exeatId: Int, completion: @escaping (HTTPStatusCode, _ result: String)->Void) {
        AF.request(
            "\(baseUrl)/student/exeat/cancelExeat?exeatId=\(exeatId)",
            method: .delete,
            encoding: JSONEncoding.default,
            headers: API.shared.deleteHeaders()
        )
        .responseString { response in
            if let statusCode = response.response?.statusCode, let result = response.value {
                completion(HTTPStatusCode.init(rawValue: statusCode), result)
            }
        }
    }
}


// MARK: LMP history
extension Repository {
    func getLMPHistory(completion: @escaping (HTTPStatusCode, [LMPHistoryResponse]?)->Void) {
        AF.request(
            "\(baseUrl)/student/lmp/getLmpHistory",
            method: .get,
            encoding: JSONEncoding.default,
            headers: API.shared.getAcceptHeaders()
        )
        .responseDecodable(of: [LMPHistoryResponse].self) { response in
            if let statusCode = response.response?.statusCode {
                completion(HTTPStatusCode.init(rawValue: statusCode), response.value)
            }
        }
    }
}


// MARK: Notice
extension Repository {
    func getNoticeTitle(dormitoryName: String, completion: @escaping (HTTPStatusCode, [NoticeTitleResponse]?)->Void) {
        // dormitory name이 한글이라 URL encoding
        let url = "\(baseUrl)/common/announcement/getAnnouncementTitles?dormitoryName=\(dormitoryName)"
        guard let encodingUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        
        AF.request(
            encodingUrl,
            method: .get,
            encoding: JSONEncoding.default,
            headers: API.shared.getAcceptHeaders()
        )
        .responseDecodable(of: [NoticeTitleResponse].self) { response in
            if let statusCode = response.response?.statusCode {
                completion(HTTPStatusCode.init(rawValue: statusCode), response.value)
            }
        }
    }
    
    func getNoticeDetail(announcementId: Int, completion: @escaping (HTTPStatusCode, NoticeDetailResponse?)->Void) {
        AF.request(
            "\(baseUrl)/common/announcement/getAnnouncement?announcementId=\(announcementId)",
            method: .get,
            encoding: JSONEncoding.default,
            headers: API.shared.getAcceptHeaders()
        )
        .responseDecodable(of: NoticeDetailResponse.self) { response in
            if let statusCode = response.response?.statusCode {
                completion(HTTPStatusCode.init(rawValue: statusCode), response.value)
            }
        }
    }
}

// MARK: Q&A
extension Repository {
    func getFAQs(completion: @escaping (HTTPStatusCode, [FAQListResponse]?)->Void) {
        AF.request(
            "\(baseUrl)/common/qna/getAllFaq",
            method: .get,
            encoding: JSONEncoding.default,
            headers: API.shared.getContentTypeHeaders()
        )
        .responseDecodable(of: [FAQListResponse].self) { response in
            if let statusCode = response.response?.statusCode {
                completion(HTTPStatusCode.init(rawValue: statusCode), response.value)
            }
        }
    }
    
    func getMyQnas(completion: @escaping (HTTPStatusCode, [MyQTitleResponse]?)->Void) {
        AF.request(
            "\(baseUrl)/student/qna/getMyQnas",
            method: .get,
            encoding: JSONEncoding.default,
            headers: API.shared.getContentTypeHeaders()
        )
        .responseDecodable(of: [MyQTitleResponse].self) { response in
            if let statusCode = response.response?.statusCode {
                completion(HTTPStatusCode.init(rawValue: statusCode), response.value)
            }
        }
    }
    
    func getQnaDetails(questionId: Int, completion: @escaping (HTTPStatusCode, MyQDetailResponse?)->Void) {
        AF.request(
            "\(baseUrl)/common/qna/getQna?questionId=\(questionId)",
            method: .get,
            encoding: JSONEncoding.default,
            headers: API.shared.getContentTypeHeaders()
        )
        .responseDecodable(of: MyQDetailResponse.self) { response in
            if let statusCode = response.response?.statusCode {
                completion(HTTPStatusCode.init(rawValue: statusCode), response.value)
            }
        }
    }
    
    func deletQuestion(questionId: Int, completion: @escaping (HTTPStatusCode, _ result: String)->Void) {
        AF.request(
            "\(baseUrl)/common/qna/deleteQuestion?questionId=\(questionId)",
            method: .delete,
            encoding: JSONEncoding.default,
            headers: API.shared.getContentTypeHeaders()
        )
        .responseString { response in
            if let statusCode = response.response?.statusCode, let result = response.value {
                completion(HTTPStatusCode.init(rawValue: statusCode), result)
            }
        }
    }
    
    func writeQuestion(writeModel: WriteQuestionModel, completion: @escaping (HTTPStatusCode, WriteQuestionResponse?)->Void) {
        AF.request(
            "\(baseUrl)/student/qna/writeQuestion",
            method: .post,
            parameters: [ "title": writeModel.title,
                          "content": writeModel.content,
                          "anonymous": writeModel.anonymous],
            encoding: JSONEncoding.default,
            headers: API.shared.getContentTypeHeaders()
        )
        .responseDecodable(of: WriteQuestionResponse.self) { response in
            if let statusCode = response.response?.statusCode {
                completion(HTTPStatusCode.init(rawValue: statusCode), response.value)
            }
        }
    }
}
