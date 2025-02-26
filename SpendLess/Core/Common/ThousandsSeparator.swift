//
//  ThousandSeparator.swift
//  SpendLess
//
//  Created by Andres Cordón on 4/2/25.
//

enum ThousandsSeparator: String, CaseIterable, Codable {
    case point = "."
    case comma = ","
    case space = " "
    
    var example: String {
        switch self {
        case .point:
            "1.000"
        case .comma:
            "1,000"
        case .space:
            "1 000"
        }
    }
}
