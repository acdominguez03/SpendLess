//
//  Untitled.swift
//  SpendLess
//
//  Created by Andres Cordón on 4/2/25.
//

enum Currency: Int, CaseIterable {
    case dollar = 0
    case euro = 1
    case pound = 2
    case yen = 3
    case franc = 4
    
    var name: String {
        switch self {
        case .dollar :
            return "US Dollar (USD)"
        case .euro:
            return "Euro (EUR)"
        case .pound:
            return "British Pound Sterling (GBP)"
        case .yen:
            return "Japanese Yen (JPY)"
        case .franc:
            return "Swiss Franc (CHF)"
        }
    }
    
    var icon: String {
        switch self {
        case .dollar :
            return "$"
        case .euro:
            return "€"
        case .pound:
            return "£"
        case .yen:
            return "¥"
        case .franc:
            return "CHF"
        }
    }
}
