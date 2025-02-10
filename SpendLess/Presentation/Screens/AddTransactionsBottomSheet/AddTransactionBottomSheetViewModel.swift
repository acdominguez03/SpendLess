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
    var priceText: String = ""
    var noteText: String = ""
    var senderReceiverPlaceholder: String = ""
    var categorySelected: Categories = Categories.other
    
    let addTransactionUseCase: AddTransactionUseCase
    
    init() {
        self.senderReceiverPlaceholder = "Receiver"
        self.addTransactionUseCase = AddTransactionUseCase(repository: TransactionRepositoryImpl.shared)
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
    
    func addTransaction(completion: @escaping () -> Void) async {
        let transaction = EncryptedTransactionModel(
            transceiver: transceiverText,
            price: Double(priceText) ?? 0.0,
            note: noteText,
            date: Date.now,
            category: nil
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
    
    func reset() {
        transceiverText = ""
        priceText = ""
        noteText = ""
        categorySelected = Categories.other
    }
}
