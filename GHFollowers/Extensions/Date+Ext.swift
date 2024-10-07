//
//  Date+Ext.swift
//  GHFollowers
//
//  Created by Mehmet Ali ÇELEBİ on 7.10.2024.
//

import Foundation

extension Date {
    func convertToMonthYearFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        return dateFormatter.string(from: self)
    }
}
