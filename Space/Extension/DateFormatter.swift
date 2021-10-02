//
//  DateFormatter.swift
//  Space_iOS
//
//  Created by lina on 2021/10/02.
//

import Foundation

extension DateFormatter {
    static let intervalDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.sssZ"
        return dateFormatter
    }()
    
    static let potedDateformatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        return dateFormatter
    }()
    
    static func calculatePostedTime(dateString: String) -> String {
        var timeString = "알 수 없음"
        if let postedTime = intervalDateFormatter.date(from: dateString) {
            let timeInterval = Int(Date().timeIntervalSince(postedTime))
            if timeInterval < 60 {
                timeString = "\(timeInterval)초 전"
            } else if timeInterval/60 < 60 {
                timeString = "\(timeInterval/60)분 전"
            } else if timeInterval/60/60 < 24 {
                timeString = "\(timeInterval/60/60)시간 전"
            } else if timeInterval/60/60/24 < 7 {
                timeString = "\(timeInterval/60/60/24)일 전"
            } else {
                timeString = potedDateformatter.string(from: postedTime)
            }
        }
        return timeString
    }
}
