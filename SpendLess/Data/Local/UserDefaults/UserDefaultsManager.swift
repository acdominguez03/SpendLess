//
//  UserDefaultsManager.swift
//  SpendLess
//
//  Created by Andres Cordón on 3/2/25.
//

import Foundation

enum ExpensesFormat: String {
    case less = "less"
    case parentheses = "parentheses"
}

enum Currency: String {
    case dollar = "US Dollar (USD)"
    case euro = "Euro (EUR)"
    case pound = "British Pound Sterling (GBP)"
    case yen = "Japanese Yen (JPY)"
    case franc = "Swiss Franc (CHF)"
}

enum DecimalSeparator: String {
    case point = "Point"
    case comma = "Comma"
}

enum ThousandsSeparator: String {
    case point = "Point"
    case comma = "Comma"
    case space = "Space"
}

enum SessionExpiryDurationMinutes: Int {
    case short = 5
    case medium = 15
    case long = 30
    case toLong = 60
}

enum LockedOutDurationSeconds: Int {
    case short = 15
    case medium = 30
    case long = 60
    case toLong = 300
}

class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    
    var expensesFormat: String? {
        set {
            UserDefaults.standard.set(Utils.shared.encrypt(text: newValue ?? ""), forKey: "expensesFormat")
        }
        get {
            return Utils.shared.decrypt(data: getEncryptedData(key: "expensesFormat") ?? Data())
        }
    }
    
    var currency: String? {
        set {
            UserDefaults.standard.set(Utils.shared.encrypt(text: newValue ?? ""), forKey: "currency")
        }
        get {
            return Utils.shared.decrypt(data: getEncryptedData(key: "currency") ?? Data())
        }
    }
    
    var decimalSeparator: String? {
        set {
            UserDefaults.standard.set(Utils.shared.encrypt(text: newValue ?? ""), forKey: "decimalSeparator")
        }
        get {
            return Utils.shared.decrypt(data: getEncryptedData(key: "decimalSeparator") ?? Data())
        }
    }
    
    var thousandsSeparator: String? {
        set {
            UserDefaults.standard.set(Utils.shared.encrypt(text: newValue ?? ""), forKey: "thousandsSeparator")
        }
        get {
            return Utils.shared.decrypt(data: getEncryptedData(key: "thousandsSeparator") ?? Data())
        }
    }
    
    var sessionExpiryDuration: Int? {
        set {
            UserDefaults.standard.set(Utils.shared.encrypt(text: String(newValue ?? 0)), forKey: "sessionExpiryDuration")
        }
        get {
            return Int(Utils.shared.decrypt(data: getEncryptedData(key: "thousandsSeparator") ?? Data()) ?? "")
        }
    }
    
    var lockedOutDuration: Int? {
        set {
            UserDefaults.standard.set(Utils.shared.encrypt(text: String(newValue ?? 0)), forKey: "lockedOutDuration")
        }
        get {
            return Int(Utils.shared.decrypt(data: getEncryptedData(key: "lockedOutDuration") ?? Data()) ?? "")
        }
    }
    
    var biometricsEnabled: Bool? {
        set {
            UserDefaults.standard.set(Utils.shared.encryptBool(boolValue: newValue ?? false), forKey: "biometricsEnabled")
        }
        get {
            return Utils.shared.decryptBool(data: getEncryptedData(key: "lockedOutDuration") ?? Data())
        }
    }
    
    func getEncryptedData(key: String) -> Data? {
        guard let encryptedData = UserDefaults.standard.data(forKey: "expensesFormat") else { return nil }
        return encryptedData
    }
}
