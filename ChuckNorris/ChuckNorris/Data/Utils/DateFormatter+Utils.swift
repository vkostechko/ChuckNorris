//
//  DateFormatter+Utils.swift
//  ChuckNorris
//
//  Created by Viachaslau Kastsechka on 3/4/23.
//

import Foundation

extension DateFormatter {
    static var defaultFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormatter.yyyyMMdd
        return dateFormatter
    }
}

extension DateFormatter {
    func stringFromDate(_ date: Date?) -> String? {
        guard let date = date else { return nil }
        return string(from: date)
    }
}

extension DateFormatter {
    static let yyyyMMdd = "yyyy-MM-dd'T'HH:mm:ssZ"
}

extension Date {
    func toString() -> String? {
        DateFormatter.defaultFormatter.stringFromDate(self)
    }
}
