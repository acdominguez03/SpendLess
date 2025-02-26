//
//  EncryptedTransactionModel.swift
//  SpendLess
//
//  Created by Andres Cordón on 14/2/25.
//

import Foundation
import SwiftData

@Model
final class EncryptedTransactionModel {
    @Attribute(.unique) var id: UUID = UUID()
    var transceiver: Data
    var amount: Data
    var note: Data
    var date: Data
    var category: Data
    var username: String
    
    init(transceiver: String, amount: Double, note: String, date: Date, category: Categories?, username: String) {
        self.transceiver = Utils.shared.encrypt(text: transceiver) ?? Data()
        self.amount = Utils.shared.encrypt(text: String(amount)) ?? Data()
        self.note = Utils.shared.encrypt(text: note) ?? Data()
        self.date = Utils.shared.encrypt(text: Utils.shared.dateToString(date)) ?? Data()
        self.category = Utils.shared.encrypt(text: category?.rawValue ?? "") ?? Data()
        self.username = username
    }
    
    func decryptAll() -> TransactionModel? {
        guard let transceiver = Utils.shared.decrypt(data: transceiver),
              let amountString = Utils.shared.decrypt(data: amount),
              let amount = Double(amountString),
              let note = Utils.shared.decrypt(data: note),
              let category = Utils.shared.decrypt(data: category) else {
            return nil
        }
        
        return TransactionModel(id: id, transceiver: transceiver, amount: amount, note: note, date: getDate() ?? Date.now, category: Categories(rawValue: category) ?? nil, username: username)
    }
    
    func getDate() -> Date? {
        guard let date = Utils.shared.decrypt(data: date) else { return nil }
        return Utils.shared.stringToDate(date)
    }
}


struct TransactionModel: Identifiable {
    var id: UUID = UUID()
    var transceiver: String = ""
    var amount: Double = 0.0
    var note: String = ""
    var date: Date = Date.now
    var category: Categories? = Categories.other
    var username: String
}
