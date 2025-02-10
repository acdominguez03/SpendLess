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
    var price: Data
    var note: Data
    var date: Data
    var category: Data
    
    init(transceiver: String, price: Double, note: String, date: Date, category: Categories?) {
        self.transceiver = Utils.shared.encrypt(text: transceiver) ?? Data()
        self.price = Utils.shared.encrypt(text: String(price)) ?? Data()
        self.note = Utils.shared.encrypt(text: note) ?? Data()
        self.date = Utils.shared.encrypt(text: Utils.shared.dateToString(date)) ?? Data()
        self.category = Utils.shared.encrypt(text: category?.rawValue ?? "") ?? Data()
    }
    
    func decryptAll() -> TransactionModel? {
        guard let transceiver = Utils.shared.decrypt(data: transceiver),
              let amountString = Utils.shared.decrypt(data: price),
              let price = Double(amountString),
              let note = Utils.shared.decrypt(data: note),
              let category = Utils.shared.decrypt(data: category) else {
            return nil
        }
        
        return TransactionModel(id: id, transceiver: transceiver, price: price, note: note, date: getDate() ?? Date.now, category: Categories(rawValue: category) ?? nil)
    }
    
    func getDate() -> Date? {
        guard let date = Utils.shared.decrypt(data: date) else { return nil }
        return Utils.shared.stringToDate(date)
    }
}


struct TransactionModel: Identifiable {
    var id: UUID = UUID()
    var transceiver: String = ""
    var price: Double = 0.0
    var note: String = ""
    var date: Date = Date.now
    var category: Categories? = Categories.other
}
