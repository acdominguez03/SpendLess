//
//  DecimalSeparator.swift
//  SpendLess
//
//  Created by Andres Cordón on 4/2/25.
//

enum DecimalSeparator: String, CaseIterable, Codable {
    case point = "."
    case comma = ","
    
    var example: String {
        switch self {
        case .point:
            "1.00"
        case .comma:
            "1,00"
        }
    }
}
