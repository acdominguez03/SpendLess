//
//  TransactionRepositoryImpl.swift
//  SpendLess
//
//  Created by Andres Cordón on 14/2/25.
//

import SwiftData
import Foundation

final class TransactionRepositoryImpl: TransactionRepository {
    
    private let swiftDataService: SwiftDataService
    private let modelContext: ModelContext
    
    @MainActor
    static let shared = TransactionRepositoryImpl()
    
    @MainActor
    private init() {
        self.swiftDataService = SwiftDataService.shared
        self.modelContext = swiftDataService.modelContext
    }
    
    func addTransaction(transaction: EncryptedTransactionModel) async -> Result<EncryptedTransactionModel, any Error> {
        modelContext.insert(transaction)
        do {
            try modelContext.save()
            return .success(transaction)
        } catch let error as NSError {
            return .failure(error)
        }
    }
    
    func getTransactions() async -> Result<[EncryptedTransactionModel], any Error> {
        let descriptor = FetchDescriptor<EncryptedTransactionModel>(predicate: nil)
        
        do {
            let transactions = try modelContext.fetch(descriptor)
            return .success(transactions)
        } catch {
            return .failure(error)
        }
    }
}
