//
//  TransactionModel.swift
//  SpendLess
//
//  Created by Andres Cordón on 3/2/25.
//

import Foundation
import SwiftData

enum ExpenseCategory: String, Codable, CaseIterable, Identifiable {
    case entertainment = "Entertainment"
    case clothing = "Clothing & Accessories"
    case education = "Education"
    case food = "Food & Groceries"
    case health = "Health & Wellness"
    
    var id: Self { self }
}


@Model
final class EncryptedExpenseModel {
    @Attribute(.unique) var id: UUID = UUID()
    var receiver: Data
    var amount: Data
    var note: Data
    var category: Data
    
    init(receiver: String, amount: Float, note: String, category: ExpenseCategory) {
        self.receiver = Utils.shared.encrypt(text: receiver) ?? Data()
        self.amount = Utils.shared.encrypt(text: String(amount)) ?? Data()
        self.note = Utils.shared.encrypt(text: note) ?? Data()
        self.category = Utils.shared.encrypt(text: category.rawValue) ?? Data()
    }
    
    func decryptAll() -> ExpenseModel? {
        guard let receiver = Utils.shared.decrypt(data: receiver),
              let amountString = Utils.shared.decrypt(data: amount),
              let amount = Float(amountString),
              let note = Utils.shared.decrypt(data: note),
              let category = Utils.shared.decrypt(data: category) else {
            return nil
        }
        
        return ExpenseModel(id: id, receiver: receiver, amount: amount, note: note, category: ExpenseCategory(rawValue: category)!)
    }
}


struct ExpenseModel: Identifiable {
    var id: UUID
    var receiver: String
    var amount: Float
    var note: String
    var category: ExpenseCategory
}
