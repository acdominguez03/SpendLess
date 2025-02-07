//
//  ExpensesFormat.swift
//  SpendLess
//
//  Created by Andres Cordón on 4/2/25.
//

enum ExpensesFormat: String, CaseIterable {
    case less = "less"
    case parentheses = "parentheses"
    
    func getExpenseExample(currencyIcon: String) -> String {
        switch self {
        case .less:
            return "-\(currencyIcon)10"
        case .parentheses:
            return "(\(currencyIcon)10)"
        }
    }
}
