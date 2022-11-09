//
//  Date+Extension.swift
//  SujungVillage-User
//
//  Created by 홍세은 on 2022/11/09.
//

import Foundation

extension Date {
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        return dateFormatter.string(from: self)
    }
    
    func toStringExceptZero() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        var day = dateFormatter.string(from: self)
        
        if day[day.index(day.startIndex, offsetBy: 8)] == "0" {
            var idx = day.index(day.startIndex, offsetBy: 8)
            day.remove(at: idx)
        }
        
        if day[day.index(day.startIndex, offsetBy: 5)] == "0" {
            var idx = day.index(day.startIndex, offsetBy: 5)
            day.remove(at: idx)
        }
        
        return day
    }
}
