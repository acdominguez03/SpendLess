//
//  AddExpenseView.swift
//  SpendLess
//
//  Created by Andres Cordón on 11/2/25.
//

import SwiftUI

enum AddTransactionFields {
    case receiverSender
    case amount
    case note
}

struct AddTransactionView: View {
    let user: UserModel
    @Binding var transceiverText: String
    @Binding var amountText: String
    @Binding var noteText: String
    @Binding var transactionSelected: String
    
    @State private var isButtonDisabled: Bool = false
    
    @Binding var transceiverPlaceholder: String
    @FocusState private var focusedField: AddTransactionFields?
    
    let expensesFormat: ExpensesFormat
    
    var onCategoryDropdownItemClicked: (Int) -> Void
    var onCreateTransactionButtonClicked: () -> Void
    
    var body: some View {
        ZStack {
            VStack(spacing: 12) {
                ZStack(alignment: .center) {
                    if transceiverText.isEmpty {
                        Text(transceiverPlaceholder)
                            .modifier(TitleMedium(color: Color("OnSurface").opacity(0.6)))
                    }
                    
                    
                    TextField("", text: $transceiverText)
                        .frame(maxWidth: UIScreen.main.bounds.width - 32)
                        .modifier(TitleMedium(color: Color("OnSurface")))
                        .multilineTextAlignment(.center)
                        .tint(Color("PrimaryApp"))
                        .fixedSize(horizontal: true, vertical: false)
                        .focused($focusedField, equals: .receiverSender)
                        .onSubmit {
                            focusedField = .amount
                        }
                }
                .frame(maxWidth: UIScreen.main.bounds.width - 32)
                .padding(.vertical, 10)
                .onTapGesture {
                    focusedField = .receiverSender
                }
                
                HStack(spacing: 6) {
                    
                    if transactionSelected == TransactionType.expense.rawValue {
                        if expensesFormat == ExpensesFormat.less {
                            Text("-\(user.currency.icon)")
                                .modifier(DisplayMedium(color: Color("Error")))
                        } else {
                            Text("(\(user.currency.icon)")
                                .modifier(DisplayMedium(color: Color("Error")))
                        }
                    } else {
                        Text("\(user.currency.icon)")
                            .modifier(DisplayMedium(color: Color("Success")))
                    }
                    
                    ZStack(alignment: .center) {
                        if amountText.isEmpty {
                            HStack(spacing: 0) {
                                Text("00.00")
                                    .modifier(DisplayMedium(color: Color("OnSurface").opacity(0.38)))
                                
                                if expensesFormat == ExpensesFormat.parentheses && transactionSelected == TransactionType.expense.rawValue {
                                    Text(")")
                                        .modifier(DisplayMedium(color: Color("Error")))
                                }
                            }
                        }
                        
                        HStack(spacing: 0) {
                            TextField("", text: $amountText)
                                .frame(maxWidth: UIScreen.main.bounds.width - 32)
                                .modifier(DisplayMedium(color: Color("OnSurface")))
                                .tint(Color("PrimaryApp"))
                                .fixedSize(horizontal: true, vertical: false)
                                .keyboardType(.decimalPad)
                                .focused($focusedField, equals: .amount)
                                .onSubmit {
                                    focusedField = .note
                                }
                            
                            if expensesFormat == ExpensesFormat.parentheses && !amountText.isEmpty && transactionSelected == TransactionType.expense.rawValue {
                                Text(")")
                                    .modifier(DisplayMedium(color: Color("Error")))
                            }
                        }
                        
                    }
                }
                .frame(maxWidth: UIScreen.main.bounds.width - 32)
                .padding(.vertical, 10)
                .onTapGesture {
                    focusedField = .amount
                }
                
                
                HStack(spacing: 6) {
                    Image(systemName: "plus")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 11, height: 11)
                        .foregroundStyle(Color("OnSurface").opacity(0.6))
                    
                    ZStack(alignment: .center) {
                        if noteText.isEmpty {
                            Text("Add Note")
                                .modifier(TitleMedium(color: Color("OnSurface").opacity(0.6)))
                        }
                        
                        
                        TextField("", text: $noteText)
                            .frame(maxWidth: UIScreen.main.bounds.width - 32)
                            .modifier(TitleMedium(color: Color("OnSurface")))
                            .multilineTextAlignment(.center)
                            .tint(Color("PrimaryApp"))
                            .fixedSize(horizontal: true, vertical: false)
                            .focused($focusedField, equals: .note)
                            .onSubmit {
                                focusedField = nil
                            }
                    }
                }
                .frame(maxWidth: UIScreen.main.bounds.width - 32)
                .onTapGesture {
                    focusedField = .note
                }
                
                if transactionSelected == TransactionType.expense.rawValue {
                    CustomSpacer(height: 50)
                    
                    CustomDropdownMenu(
                        items: Categories.allCases.map({ category in
                            DropdownItem(
                                id: category.id,
                                title: category.rawValue,
                                icon: category.icon,
                                onSelect: { value in
                                    onCategoryDropdownItemClicked(value)
                                }
                            )
                        }),
                        customDropdownMenuType: CustomDropdownMenuTypes.categories
                    )
                    .frame(height: 50)
                    .zIndex(10)
                } else {
                    CustomSpacer(height: 110)
                }
                
                
                CustomButton(
                    text: "Create",
                    isDisabled: isButtonDisabled,
                    onClick: {
                        onCreateTransactionButtonClicked()
                    }
                )
                
                Spacer()
            }
            .padding(.horizontal, 16)
            .zIndex(1)
        }
        .onAppear {
            focusedField = .receiverSender
            isButtonDisabled = transceiverText.isEmpty || amountText.isEmpty
        }
        .onChange(of: transceiverText) { oldValue, newValue in
            isButtonDisabled = transceiverText.isEmpty || amountText.isEmpty
        }
        .onChange(of: noteText) { oldValue, newValue in
            isButtonDisabled = transceiverText.isEmpty || amountText.isEmpty
        }
        .onChange(of: amountText) { oldValue, newValue in
            isButtonDisabled = transceiverText.isEmpty || amountText.isEmpty
        }
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                
                Button("Ready") {
                    switch focusedField {
                    case .receiverSender:
                        focusedField = .amount
                    case .amount:
                        focusedField = .note
                    case .note:
                        focusedField = nil
                    case nil:
                        break
                    }
                }
            }
        }
    }
}

#Preview {
    AddTransactionView(
        user: UserModel(),
        transceiverText: .constant(""),
        amountText: .constant(""),
        noteText: .constant(""),
        transactionSelected: .constant(""),
        transceiverPlaceholder: .constant("Receiver"),
        expensesFormat: ExpensesFormat.less,
        onCategoryDropdownItemClicked: {_ in },
        onCreateTransactionButtonClicked: {}
    )
}
