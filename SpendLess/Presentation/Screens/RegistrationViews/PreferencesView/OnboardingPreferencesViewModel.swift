//
//  OnboardingPreferencesViewModel.swift
//  SpendLess
//
//  Created by Andres Cordón on 6/2/25.
//

import Foundation
import SwiftUI

@Observable
@MainActor final class OnboardingPreferencesViewModel {
    var path: Binding<[Screen]>?
    
    var currency = Currency.euro
    var decimalSeparator = DecimalSeparator.comma
    var expensesFormat = ExpensesFormat.less
    var thousandsSeparator = ThousandsSeparator.point
    
    var buttonDisabled: Bool = false
    
    var exampleText = ""
    
    var expensesFormatValue: [String] = []
    
    let createUserUseCase: CreateUserUseCaseProtocol
    
    init() {
        self.createUserUseCase = CreateUserUseCase(repository: UserRepositoryImpl.shared())
        self.exampleText = "-\(currency.icon)10\(thousandsSeparator.rawValue)382\(decimalSeparator.rawValue)45"
        self.buttonDisabled = decimalSeparator.rawValue == thousandsSeparator.rawValue
        self.expensesFormatValue = ExpensesFormat.allCases.map({ expense in
            expense.getExpenseExample(currencyIcon: currency.icon)
        })
    }
    
    func changeExpensesFormatValue(value: String) {
        if ExpensesFormat.less.getExpenseExample(currencyIcon: currency.icon) == value {
            expensesFormat = ExpensesFormat.less
        } else {
            expensesFormat = ExpensesFormat.parentheses
        }
        
        updateExampleText()
    }
    
    func changeDecimalSeparatorValue(value: String) {
        if DecimalSeparator.comma.example == value {
            decimalSeparator = DecimalSeparator.comma
        } else {
            decimalSeparator = DecimalSeparator.point
        }
        
        updateExampleText()
        updateButtonDisabled()
    }
    
    func changeThousandsSeparatorValue(value: String) {
        if ThousandsSeparator.comma.example == value {
            thousandsSeparator = ThousandsSeparator.comma
        } else if ThousandsSeparator.point.example == value {
            thousandsSeparator = ThousandsSeparator.point
        } else {
            thousandsSeparator = ThousandsSeparator.space
        }
        
        updateExampleText()
        updateButtonDisabled()
    }
    
    func changeCurrencyValue(id: Int) {
        currency = Currency(rawValue: id) ?? Currency.dollar
        expensesFormatValue = ExpensesFormat.allCases.map({ expense in
            expense.getExpenseExample(currencyIcon: currency.icon)
        })
        changeExpensesFormatValue(value: expensesFormat.getExpenseExample(currencyIcon: currency.icon))
    }
    
    func updateExampleText() {
        switch expensesFormat {
        case .less:
            exampleText = "-\(currency.icon)10\(thousandsSeparator.rawValue)382\(decimalSeparator.rawValue)45"
        case .parentheses:
            exampleText = "(\(currency.icon)10\(thousandsSeparator.rawValue)382\(decimalSeparator.rawValue)45)"
        }
    }
    
    func updateButtonDisabled() {
        buttonDisabled = decimalSeparator.rawValue == thousandsSeparator.rawValue
    }
    
    func onSaveButtonClicked() async {
        let encryptedUserModel = EncryptedUserModel(
            username: UserDefaultsManager.shared.username ?? "",
            code: UserDefaultsManager.shared.pin ?? "",
            lastConnection: Date.now,
            expensesFormat: expensesFormat,
            currency: currency,
            decimalSeparator: decimalSeparator,
            thousandsSeparator: thousandsSeparator,
            sessionExpirityDuration: SessionExpiryDuration.short,
            lockedOutDuration: LockedOutDuration.short
        )
        
        let result = await createUserUseCase.execute(userModel: encryptedUserModel)
        
        switch result {
        case .success(let user):
            print(user)
        case .failure(let error):
            print(error)
        }
    }
    
    func onBackButtonPressed() {
        DispatchQueue.main.async {
            self.path?.wrappedValue.removeLast(2)
        }
    }
}
