//
//  AddTransactionUseCase.swift
//  SpendLess
//
//  Created by Andres Cordón on 14/2/25.
//

protocol AddTransactionUseCaseProtocol {
    func execute(transaction: EncryptedTransactionModel) async -> Result<TransactionModel?, Error>
}

class AddTransactionUseCase: AddTransactionUseCaseProtocol {
    let repository: TransactionRepository
    
    init(repository: TransactionRepository) {
        self.repository = repository
    }
    
    func execute(transaction: EncryptedTransactionModel) async -> Result<TransactionModel?, any Error> {
        let result = await repository.addTransaction(transaction: transaction)

        switch result {
        case .success(let transaction):
            return .success(transaction.decryptAll() ?? nil)
        case .failure(let error):
            return .failure(error)
        }
    }
}
