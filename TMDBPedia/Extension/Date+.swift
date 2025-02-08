//
//  Date+.swift
//  TMDBPedia
//
//  Created by 변정훈 on 2/1/25.
//

import Foundation

extension Date {
    func toDateDayString() -> String {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "KST")
        formatter.dateFormat = "yy.MM.dd 가입"
        let dateString = formatter.string(from: self)
        return dateString
    }
}
