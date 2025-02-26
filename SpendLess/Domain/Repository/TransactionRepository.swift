//
//  TransactionRepository.swift
//  SpendLess
//
//  Created by Andres Cordón on 14/2/25.
//

protocol TransactionRepository {
    func addTransaction(transaction: EncryptedTransactionModel) async -> Result<EncryptedTransactionModel, Error>
    func getTransactions(username: String) async -> Result<[EncryptedTransactionModel], Error>
}
