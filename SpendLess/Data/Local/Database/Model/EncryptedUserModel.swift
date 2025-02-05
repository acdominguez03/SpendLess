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
final class EncryptedUserModel {
    @Attribute(.unique) var username: Data
    var code: Data
    var lastConnection: Data
    var expensesFormat: Data
    var currency: Data
    var decimalSeparator: Data
    var thousandsSeparator: Data
    var sessionExpirityDuration: Data
    var lockedOutDuration: Data
    
    init(username: String, code: String, lastConnection: Date, expensesFormat: ExpensesFormat, currency: Currency, decimalSeparator: DecimalSeparator, thousandsSeparator: ThousandsSeparator, sessionExpirityDuration: SessionExpiryDuration, lockedOutDuration: LockedOutDuration) {
        self.username = Utils.shared.encrypt(text: username) ?? Data()
        self.code = Utils.shared.encrypt(text: code) ?? Data()
        self.lastConnection = Utils.shared.encrypt(text: Utils.shared.dateToString(lastConnection)) ?? Data()
        self.expensesFormat = Utils.shared.encrypt(text: expensesFormat.rawValue) ?? Data()
        self.currency = Utils.shared.encrypt(text: currency.rawValue) ?? Data()
        self.decimalSeparator = Utils.shared.encrypt(text: decimalSeparator.rawValue) ?? Data()
        self.thousandsSeparator = Utils.shared.encrypt(text: thousandsSeparator.rawValue) ?? Data()
        self.sessionExpirityDuration = Utils.shared.encrypt(text: String(sessionExpirityDuration.rawValue)) ?? Data()
        self.lockedOutDuration = Utils.shared.encrypt(text: String(lockedOutDuration.rawValue)) ?? Data()
    }
    
    func decryptAll() -> UserModel? {
        guard let username = Utils.shared.decrypt(data: username),
            let code = Utils.shared.decrypt(data: code),
            let expensesFormat = Utils.shared.decrypt(data: expensesFormat),
            let currency = Utils.shared.decrypt(data: currency),
            let decimalSeparator = Utils.shared.decrypt(data: decimalSeparator),
            let thousandsSeparator = Utils.shared.decrypt(data: thousandsSeparator),
            let sessionExpirityDuration = Utils.shared.decrypt(data: sessionExpirityDuration),
            let lockedOutDuration = Utils.shared.decrypt(data: lockedOutDuration) else {
            return nil
        }
        
        return UserModel(
            username: username,
            code: code,
            lastConnection: getLastConnection() ?? Date.now,
            expensesFormat: ExpensesFormat(rawValue: expensesFormat) ?? ExpensesFormat.less,
            currency: Currency(rawValue: currency) ?? Currency.euro,
            decimalSeparator: DecimalSeparator(rawValue: decimalSeparator) ?? DecimalSeparator.comma,
            thousandsSeparator: ThousandsSeparator(rawValue: thousandsSeparator) ?? ThousandsSeparator.point,
            sessionExpirityDuration: SessionExpiryDuration(rawValue: Int(sessionExpirityDuration) ?? 5) ?? SessionExpiryDuration.short,
            lockedOutDuration: LockedOutDuration(rawValue: Int(lockedOutDuration) ?? 15) ?? LockedOutDuration.short
        )
    }
    
    func getUsername() -> String? {
        return Utils.shared.decrypt(data: username)
    }
    
    func getLastConnection() -> Date? {
        guard let date = Utils.shared.decrypt(data: lastConnection) else { return nil }
        return Utils.shared.stringToDate(date)
    }
    
    func getCode() -> String? {
        return Utils.shared.decrypt(data: code)
    }
    
    
}

struct UserModel {
    var username: String
    var code: String
    var lastConnection: Date
    var expensesFormat: ExpensesFormat
    var currency: Currency
    var decimalSeparator: DecimalSeparator
    var thousandsSeparator: ThousandsSeparator
    var sessionExpirityDuration: SessionExpiryDuration
    var lockedOutDuration: LockedOutDuration
}
