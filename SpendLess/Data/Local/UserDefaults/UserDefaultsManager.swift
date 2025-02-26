//
//  UserDefaultsManager.swift
//  SpendLess
//
//  Created by Andres Cordón on 3/2/25.
//

import Foundation
class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    
    var username: String? {
        set {
            UserDefaults.standard.set(Utils.shared.encrypt(text: newValue ?? ""), forKey: "username")
        }
        get {
            return Utils.shared.decrypt(data: getEncryptedData(key: "username") ?? Data())
        }
    }
    
    var pin: String {
        set {
            UserDefaults.standard.set(Utils.shared.hashValue(value: newValue), forKey: "pin")
        }
        get {
            return UserDefaults.standard.string(forKey: "pin") ?? ""
        }
    }
    
    var isLogged: Bool? {
        set {
            UserDefaults.standard.set(Utils.shared.encryptBool(value: newValue ?? false), forKey: "isLogged")
        }
        get {
            return Utils.shared.decryptBool(data: getEncryptedData(key: "isLogged") ?? Data())
        }
    }
    
    func resetPin() {
        UserDefaults.standard.set(Utils.shared.encrypt(text: ""), forKey: "pin")
    }
    
    func getEncryptedData(key: String) -> Data? {
        guard let encryptedData = UserDefaults.standard.data(forKey: key) else { return nil }
        return encryptedData
    }
}
