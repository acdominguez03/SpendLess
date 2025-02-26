//
//  UserModel.swift
//  SpendLess
//
//  Created by Andres Cordón on 3/2/25.
//

import SwiftData
import Foundation
import CryptoKit

@Model
final class UserModel {
    @Attribute(.unique) var username: String = ""
    var pin: String = ""
    var lastConnection: Date = Date.now
    var expensesFormat: ExpensesFormat = ExpensesFormat.less
    var currency: Currency = Currency.euro
    var decimalSeparator: DecimalSeparator = DecimalSeparator.comma
    var thousandsSeparator: ThousandsSeparator = ThousandsSeparator.point
    var sessionExpirityDuration: SessionExpiryDuration = SessionExpiryDuration.short
    var lockedOutDuration: LockedOutDuration = LockedOutDuration.short
    var isLogged: Bool = false
    
    init(username: String, pin: String, lastConnection: Date, expensesFormat: ExpensesFormat, currency: Currency, decimalSeparator: DecimalSeparator, thousandsSeparator: ThousandsSeparator, sessionExpirityDuration: SessionExpiryDuration, lockedOutDuration: LockedOutDuration) {
        self.username = username
        self.pin = pin
        self.lastConnection = lastConnection
        self.expensesFormat = expensesFormat
        self.currency = currency
        self.decimalSeparator = decimalSeparator
        self.thousandsSeparator = thousandsSeparator
        self.sessionExpirityDuration = sessionExpirityDuration
        self.lockedOutDuration = lockedOutDuration
    }
    
    init() {
        
    }
}
