//
//  DateFormatter+Utils.swift
//  ChuckNorris
//
//  Created by Viachaslau Kastsechka on 3/4/23.
//

import Foundation

extension DateFormatter {
    static var serverFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormatter.server
        return dateFormatter
    }

    static var presentationFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormatter.yyyyMMddHHmm
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
    static let server = "yyyy-MM-dd HH:mm:ss.SSSSSS"
    static let yyyyMMddHHmm = "yyyy MM dd HH:mm"
}

extension Date {
    func toString() -> String? {
        DateFormatter.presentationFormatter.stringFromDate(self)
    }
}
