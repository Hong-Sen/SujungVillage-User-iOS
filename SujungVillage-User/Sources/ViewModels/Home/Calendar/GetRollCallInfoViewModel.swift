//
//  GetRollCallInfoViewModel.swift
//  SujungVillage-User
//
//  Created by 홍세은 on 2022/10/20.
//

import Foundation
import UIKit

class GetRollCallInfoViewModel {
    static let shared = GetRollCallInfoViewModel()
    private init() {}
    let repository =  Repository()
    var onUpdated: () -> Void = {}
    var rollcallId: Int = -101
    
    var image: UIImage = UIImage(named: "img_not_load")!
    {
        didSet {
            onUpdated()
        }
    }
    
    var location: String = ""
    {
        didSet {
            onUpdated()
        }
    }
    
    var time: String = ""
    {
        didSet {
            onUpdated()
        }
    }
    
    func convertImage(imgUrl:[Int8]) -> UIImage? {
        let datos: NSData = NSData(bytes: imgUrl, length: imgUrl.count)
        return UIImage(data: datos as Data)
    }
    
    func fetchRollCallAlert() {
        self.repository.getRollCallInfo(rollcallId: rollcallId) { status, response in
            switch status {
            case .ok:
                if let imgUrl = response?.image,
                    let location = response?.location,
                   let rollcallTime = response?.rollcallDateTime {
                    self.image = self.convertImage(imgUrl: imgUrl)!
                    self.location = location
                
                    //"2022-08-11T19:29:47.782682"
                    var formatTime = rollcallTime.replacingOccurrences(of: "T", with: " ")
                    self.time = String(formatTime.prefix(19))
                }
                break
            default:
                print("fetch roll call alert error: \(status)")
                break
            }
        }
    }
}

