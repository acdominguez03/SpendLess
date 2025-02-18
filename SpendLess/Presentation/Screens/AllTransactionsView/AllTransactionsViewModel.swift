//
//  AllTransactionsViewModel.swift
//  SpendLess
//
//  Created by Andres Cordón on 16/2/25.
//

import Foundation
import SwiftUI

@Observable
@MainActor final class AllTransactionsViewModel {
    var path: Binding<[Screen]>?
    
    var transactions: [TransactionModel] = []
    var currency: Currency = Currency.franc
    
    let getTransactionsUseCase: GetTransactionsUseCase
    let getUserByUsernameUseCase: GetUserByUsernameUseCase
    
    init() {
        self.getUserByUsernameUseCase = GetUserByUsernameUseCase(repository: UserRepositoryImpl.shared)
        self.getTransactionsUseCase = GetTransactionsUseCase(repository: TransactionRepositoryImpl.shared)
    }
    
    func getTransactions() async {
        let result = await getTransactionsUseCase.execute()
        
        switch result {
        case .success(let transactions):
            self.transactions = transactions.sorted{ $0.date > $1.date }
        case .failure(let error):
            print(error)
        }
    }
    
    func getUserData() async {
        let result = await getUserByUsernameUseCase.execute(username: UserDefaultsManager.shared.username ?? "")
        
        switch result {
        case .success(let user):
            self.currency = user.currency
        case .failure(let error):
            print(error)
        }
    }
}
