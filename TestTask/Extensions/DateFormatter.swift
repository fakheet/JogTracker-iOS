//
//  DateFormatter.swift
//  TestTask
//
//  Created by mage on 22.11.2021.
//

import Foundation

extension DateFormatter {
    static let defaultJogDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d/M/yyyy"
        return formatter
    }()
}
