//
//  AddTransactionBottomSheetViewModel.swift
//  SpendLess
//
//  Created by Andres Cordón on 13/2/25.
//

import Foundation

@Observable
@MainActor final class AddTransactionBottomSheetViewModel {
    
    var transactionSelected: String = TransactionType.expense.rawValue
    
    var transceiverText: String = ""
    var amountText: String = ""
    var noteText: String = ""
    var senderReceiverPlaceholder: String = ""
    var user: UserModel = UserModel()
    var categorySelected: Categories = Categories.clothing
    
    var showError: Bool = false
    var errorMessage: String = ""
    
    let addTransactionUseCase: AddTransactionUseCase
    let getLoggedUserUseCase: GetLoggedUserUseCase
    
    init() {
        self.senderReceiverPlaceholder = "Receiver"
        self.addTransactionUseCase = AddTransactionUseCase(repository: TransactionRepositoryImpl.shared)
        self.getLoggedUserUseCase = GetLoggedUserUseCase(repository: UserRepositoryImpl.shared)
    }
    
    func onCategoryDropdownMenuItemClicked(value: Int) {
        categorySelected = Categories.allCases.first(where: { $0.id == value }) ?? Categories.entertainment
    }
    
    func onValueSelectorCLicked(value: String) {
        transactionSelected = value
        if value == TransactionType.expense.rawValue {
            senderReceiverPlaceholder = "Receiver"
        } else {
            senderReceiverPlaceholder = "Sender"
        }
    }
    
    func getUserData() async {
        let result = await getLoggedUserUseCase.execute()
        
        switch result {
        case .success(let user):
            if user != nil {
                self.user = user!
            }
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
    
    func addTransaction(completion: @escaping () -> Void) async {
        errorMessage = ""
        let amountDouble = Utils.shared.formatAmountDecimalSeparator(amount: amountText)
        
        if (transceiverText.count < 3) {
            errorMessage = "Transceiver must be at least 3 characters"
            showError = true
        } else {
            if !Utils.shared.checkIfTextIsOnlyLettersAndNumber(transceiverText) {
                errorMessage = "Only alphanumeric and digits are allowed"
                showError = true
            } else if amountDouble <= 0 {
                errorMessage = "The amount must be higher than 0.0"
                showError = true
            } else if noteText.count > 100 {
                errorMessage = "The note is too long. The max count is 100 characters"
                showError = true
            } else {
                let transaction = EncryptedTransactionModel(
                    transceiver: transceiverText,
                    amount: amountDouble,
                    note: noteText,
                    date: Date.now,
                    category: nil,
                    username: user.username
                )
                
                if transactionSelected == TransactionType.expense.rawValue {
                    transaction.category = Utils.shared.encrypt(text: categorySelected.rawValue) ?? Data()
                }
                
                let result = await addTransactionUseCase.execute(transaction: transaction)
                
                switch result {
                case .success(let transaction):
                    if transaction != nil {
                        reset()
                        completion()
                    } else {
                        print("Error in the proccess")
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func reset() {
        transceiverText = ""
        amountText = ""
        noteText = ""
        categorySelected = Categories.other
    }
}
