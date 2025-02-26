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
    var path: Binding<[Views]>?
    
    var user: UserModel?
    var currency: Currency = Currency.dollar
    var decimalSeparator: DecimalSeparator = DecimalSeparator.comma
    var thousandSeparator: ThousandsSeparator = ThousandsSeparator.space
    var expensesFormat: ExpensesFormat = ExpensesFormat.less
    var transactions: [TransactionModel] = []
    
    var categoryWithTheHighestSpending: Categories = Categories.clothing
    var largestTransaction: TransactionModel? = nil
    var totalExpensesForTheWeek: Double = 0.0
    
    var accountBalanceString: String = "0.00"
    
    let getLoggedUserUseCase: GetLoggedUserUseCase
    let getTransactionsByUsernameUseCase: GetTransactionsByUsernameUseCase
    
    init() {
        self.getLoggedUserUseCase = GetLoggedUserUseCase(repository: UserRepositoryImpl.shared)
        self.getTransactionsByUsernameUseCase = GetTransactionsByUsernameUseCase(repository: TransactionRepositoryImpl.shared)
    }
    
    func getTransactions() async {
        let result = await getTransactionsByUsernameUseCase.execute(username: user?.username ?? "")
        
        switch result {
        case .success(let transactions):
            self.transactions = transactions.sorted{ $0.date > $1.date }
            self.getAccountBalance()
            self.getCategoryWithTheHighestSpending()
            self.getLargestTransaction()
            self.getTotalExpensesForTheWeek()
        case .failure(let error):
            print(error)
        }
    }
    
    func getUserData() async {
        let result = await getLoggedUserUseCase.execute()
        
        switch result {
        case .success(let user):
            self.user = user
            self.currency = user!.currency
            self.decimalSeparator = user!.decimalSeparator
            self.thousandSeparator = user!.thousandsSeparator
            self.expensesFormat = user!.expensesFormat
        case .failure(let error):
            print(error)
        }
    }
    
    func getCategoryWithTheHighestSpending() {
        var categoriesWithSpending: [Categories: Double] = [:]
        transactions.forEach { transaction in
            if let category = transaction.category {
                //Cuando la categoría existe en el array y cuando no
                if let existingCategory = categoriesWithSpending[category] {
                    categoriesWithSpending[category] = existingCategory + transaction.amount
                } else {
                    categoriesWithSpending[category] = transaction.amount
                }
            }
        }
        
        if let bestCategoryInMap = categoriesWithSpending.max(by: { $0.value < $1.value }) {
            categoryWithTheHighestSpending = bestCategoryInMap.key
        }
    }
    
    func getLargestTransaction() {
        largestTransaction = transactions.compactMap({ transaction in
            transaction.category != nil ? transaction : nil
        }).max(by: { $0.amount < $1.amount })
    }
    
    func getTotalExpensesForTheWeek() {
        totalExpensesForTheWeek = 0.0
        transactions.forEach { transaction in
            if Calendar.current.isDate(transaction.date, equalTo: Date.now, toGranularity: .weekOfYear) && transaction.category != nil {
                totalExpensesForTheWeek += transaction.amount
            }
        }
    }
    
    func getAccountBalance() {
        var accountBalance = 0.0
        transactions.forEach { transaction in
            if transaction.category != nil {
                accountBalance -= transaction.amount
            } else {
                accountBalance += transaction.amount
            }
        }
        
        if let user = user {
            accountBalanceString = Utils.shared.formatNumberWithUserSettings(amount: abs(accountBalance), currency: user.currency, decimalSeparator: user.decimalSeparator, thousandSeparator: user.thousandsSeparator, expensesFormat: accountBalance < 0 ? user.expensesFormat : nil)
        }
    }
    
    func navigateToSettings() {
        DispatchQueue.main.async {
            self.path?.wrappedValue.append(Views.SettingsView)
        }
       
    }
}
