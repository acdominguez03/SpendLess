//
//  IncomeModel.swift
//  SpendLess
//
//  Created by Andres Cordón on 3/2/25.
//

import SwiftData
import Foundation

@Model
final class EncryptedIncomeModel {
    @Attribute(.unique) var id: UUID = UUID()
    var sender: Data
    var amount: Data
    var note: Data
    
    init(sender: String, amount: Float, note: String) {
        self.sender = Utils.shared.encrypt(text: sender) ?? Data()
        self.amount = Utils.shared.encrypt(text: String(amount)) ?? Data()
        self.note = Utils.shared.encrypt(text: note) ?? Data()
    }
    
    func decryptAll() -> IncomeModel? {
        guard let sender = Utils.shared.decrypt(data: sender),
              let amountString = Utils.shared.decrypt(data: amount),
              let amount = Float(amountString),
              let note = Utils.shared.decrypt(data: note) else {
            return nil
        }
        
        return IncomeModel(id: id, sender: sender, amount: amount, note: note)
    }
}

struct IncomeModel {
    var id: UUID
    var sender: String
    var amount: Float
    var note: String
}
