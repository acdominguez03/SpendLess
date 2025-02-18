//
//  GetTransactionsUseCase.swift
//  SpendLess
//
//  Created by Andres Cordón on 14/2/25.
//

protocol GetTransactionsUseCaseProtocol {
    func execute() async -> Result<[TransactionModel], Error>
}

class GetTransactionsUseCase: GetTransactionsUseCaseProtocol {
    
    let repository: TransactionRepository
    
    init(repository: TransactionRepository) {
        self.repository = repository
    }
    
    func execute() async -> Result<[TransactionModel], Error> {
        let result = await repository.getTransactions()

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
