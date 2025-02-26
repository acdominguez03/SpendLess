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
    var decimalSeparator: DecimalSeparator = DecimalSeparator.comma
    var thousandSeparator: ThousandsSeparator = ThousandsSeparator.space
    var expensesFormat: ExpensesFormat = ExpensesFormat.less
    
    let getTransactionsByUsernameUseCase: GetTransactionsByUsernameUseCase
    let getLoggedUserUseCase: GetLoggedUserUseCase
    
    init() {
        self.getLoggedUserUseCase = GetLoggedUserUseCase(repository: UserRepositoryImpl.shared)
        self.getTransactionsByUsernameUseCase = GetTransactionsByUsernameUseCase(repository: TransactionRepositoryImpl.shared)
    }
    
    func getTransactions() async {
        let result = await getTransactionsByUsernameUseCase.execute(username: UserDefaultsManager.shared.username ?? "")
        
        switch result {
        case .success(let transactions):
            self.transactions = transactions.sorted{ $0.date > $1.date }
        case .failure(let error):
            print(error)
        }
    }
    
    func getUserData() async {
        let result = await getLoggedUserUseCase.execute()
        
        switch result {
        case .success(let user):
            if let userNotNull = user {
                self.currency = userNotNull.currency
                self.expensesFormat = userNotNull.expensesFormat
                self.decimalSeparator = userNotNull.decimalSeparator
                self.thousandSeparator = userNotNull.thousandsSeparator
            }
        case .failure(let error):
            print(error)
        }
    }
}
