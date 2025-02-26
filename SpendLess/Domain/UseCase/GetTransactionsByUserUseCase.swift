//
//  GetTransactionsUseCase.swift
//  SpendLess
//
//  Created by Andres Cordón on 14/2/25.
//

protocol GetTransactionsByUsernameUseCaseProtocol {
    func execute(username: String) async -> Result<[TransactionModel], Error>
}

class GetTransactionsByUsernameUseCase: GetTransactionsByUsernameUseCaseProtocol {
    
    let repository: TransactionRepository
    
    init(repository: TransactionRepository) {
        self.repository = repository
    }
    
    func execute(username: String) async -> Result<[TransactionModel], Error> {
        let result = await repository.getTransactions(username: username)

        switch result {
        case .success(let transactions):
            return .success(transactions.compactMap({ encryptedTransaction in
                encryptedTransaction.decryptAll()
            }))
        case .failure(let error):
            return .failure(error)
        }
    }
}
