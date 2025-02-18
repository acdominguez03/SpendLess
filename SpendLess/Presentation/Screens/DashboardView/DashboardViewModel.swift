//
//  DashboardViewModel.swift
//  SpendLess
//
//  Created by Andres Cordón on 14/2/25.
//

import Foundation
import SwiftUI

@Observable
@MainActor final class DashboardViewModel {
    var path: Binding<[Screen]>?
    
    var user: UserModel?
    var transactions: [TransactionModel] = []
    
    var accountBalanceString: String = "0.00"
    
    let getUserByUsernameUseCase: GetUserByUsernameUseCase
    let getTransactionsUseCase: GetTransactionsUseCase
    
    init() {
        self.getUserByUsernameUseCase = GetUserByUsernameUseCase(repository: UserRepositoryImpl.shared)
        self.getTransactionsUseCase = GetTransactionsUseCase(repository: TransactionRepositoryImpl.shared)
    }
    
    func getTransactions() async {
        let result = await getTransactionsUseCase.execute()
        
        switch result {
        case .success(let transactions):
            self.transactions = transactions.sorted{ $0.date > $1.date }
            self.getAccountBalance()
        case .failure(let error):
            print(error)
        }
    }
    
    func getUserData() async {
        let result = await getUserByUsernameUseCase.execute(username: UserDefaultsManager.shared.username ?? "")
        
        switch result {
        case .success(let user):
            self.user = user
        case .failure(let error):
            print(error)
        }
    }
    
    func getAccountBalance() {
        var accountBalance = 0.0
        transactions.forEach { transaction in
            if transaction.category != nil {
                accountBalance -= transaction.price
            } else {
                accountBalance += transaction.price
            }
        }
        
        accountBalanceString = String(format: "%.2f", accountBalance)
        if accountBalance < 0 {
            let insertIndex = accountBalanceString.index(accountBalanceString.startIndex, offsetBy: 1)
            if let icon = user?.currency.icon.first {
                accountBalanceString.insert(icon, at: insertIndex)
            }
        } else {
            let insertIndex = accountBalanceString.index(accountBalanceString.startIndex, offsetBy: 0)
            if let icon = user?.currency.icon.first {
                accountBalanceString.insert(icon, at: insertIndex)
            }
        }
    }
}
