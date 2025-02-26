//
//  Extensions.swift
//  SpendLess
//
//  Created by Andres Cordón on 20/2/25.
//

import Foundation
import SwiftUI

extension Date {
    func dateToString(format: String = "MMM d, yyyy") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        
        return formatter.string(from: self)
    }
    
    func toTodayYesterdayOrDate(format: String = "d MMM YYYY") -> String {
        if Calendar.current.isDateInToday(self) {
            return "TODAY"
        } else if Calendar.current.isDateInYesterday(self) {
            return  "YESTERDAY"
        } else {
            return self.dateToString(format: format)
        }
    }
}

extension String {
    func formatTextWithCurrencyAndExpensesFormat(currency: Currency, expensesFormat: ExpensesFormat) -> String {
        if expensesFormat == ExpensesFormat.less {
            return "-\(currency.icon)\(self)"
        } else {
            return "(\(currency.icon)\(self))"
        }
    }
    
    func formatTextWithCurrency(currency: Currency) -> String {
        return "\(currency.icon)\(self)"
    }
}

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
