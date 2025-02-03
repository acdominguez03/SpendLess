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
    var sessionDate: Data
   
    init(username: String, code: String, sessionDate: Date = Date.now) {
        self.username = Utils.shared.encrypt(text: username) ?? Data()
        self.code = Utils.shared.encrypt(text: code) ?? Data()
        self.sessionDate = Utils.shared.encrypt(text: Utils.shared.dateToString(sessionDate)) ?? Data()
    }
    
    func getUsername() -> String? {
        return Utils.shared.decrypt(data: username)
    }
    
    func getSessionDate() -> Date? {
        guard let date = Utils.shared.decrypt(data: sessionDate) else { return nil }
        return Utils.shared.stringToDate(date)
    }
    
    func getCode() -> String? {
        return Utils.shared.decrypt(data: code)
    }
}
