//
//  DateFormatter+Extension.swift
//  INewsNow
//
//  Created by Pedro Henrique on 21/02/24.
//

import Foundation

extension DateFormatter {
    
    enum LocaleType {
        case brazil
        case unitedStates
    }
    
    static func formatterDate(dateString: String, locale: LocaleType) -> String {
        if dateString.isEmpty {
            return "Date Not Found"
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = locale == .brazil ? Locale(identifier: "pt_BR") : Locale(identifier: "en_US_POSIX")
            
            if dateString.contains("T") {
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
            } else if dateString.contains(":") {
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            } else {
                dateFormatter.dateFormat = "yyyy-MM-dd"
            }
            if let date = dateFormatter.date(from: dateString) {
                dateFormatter.dateFormat = locale == .brazil ? "dd MMMM - yyyy" : "MMM dd - yyyy"
                return dateFormatter.string(from: date)
            } else {
                return ""
            }
        }
    }
}
