//
//  AddExpenseView.swift
//  SpendLess
//
//  Created by Andres Cordón on 11/2/25.
//

import SwiftUI

enum AddTransactionFields {
    case receiverSender
    case price
    case note
}

struct AddTransactionView: View {
    let user: UserModel
    @Binding var senderReceiverText: String
    @Binding var priceText: String
    @Binding var noteText: String
    @Binding var transactionSelected: String
    
    @Binding var senderReceiverPlaceholder: String
    @FocusState private var focusedField: AddTransactionFields?
    
    var onCategoryDropdownItemClicked: (Int) -> Void
    var onCreateTransactionButtonClicked: () -> Void
    
    var body: some View {
        ZStack {
            VStack(spacing: 12) {
                TextField("", text: $senderReceiverText, prompt: Text(senderReceiverPlaceholder).foregroundStyle(Color("OnSurface").opacity(0.6)))
                        .modifier(TitleMedium(color: Color("OnSurface")))
                        .tint(Color("PrimaryApp"))
                        .multilineTextAlignment(.center)
                        .focused($focusedField, equals: .receiverSender)
                        .onSubmit {
                            focusedField = .price
                        }
                
                HStack(spacing: 4) {
                    Spacer()
                    
                    let expensesFormat = ExpensesFormat.less
                    
                    if transactionSelected == TransactionType.expense.rawValue {
                        if expensesFormat == ExpensesFormat.less {
                            Text("-\(user.currency.icon)")
                                .modifier(DisplayMedium(color: Color("Error")))
                        } else {
                            Text("(\(user.currency.icon))")
                                .modifier(DisplayMedium(color: Color("Error")))
                        }
                    } else {
                        Text("\(user.currency.icon)")
                            .modifier(DisplayMedium(color: Color("Success")))
                    }
                    
                    TextField("", text: $priceText, prompt: Text("00.00").foregroundStyle(Color("OnSurface").opacity(0.38)))
                        .modifier(DisplayMedium(color: Color("OnSurface")))
                        .tint(Color("PrimaryApp"))
                        .frame(minWidth: 0)
                        .fixedSize(horizontal: true, vertical: false)
                        .focused($focusedField, equals: .price)
                        .onSubmit {
                            focusedField = .note
                        }
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 10)
                
                HStack(spacing: 6) {
                    Image(systemName: "plus")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 11, height: 11)
                        .foregroundStyle(Color("OnSurface").opacity(0.6))
                    
                    TextField("", text: $noteText, prompt: Text("Add Note").foregroundStyle(Color("OnSurface").opacity(0.6)))
                        .modifier(TitleMedium(color: Color("OnSurface")))
                        .tint(Color("PrimaryApp"))
                        .focused($focusedField, equals: .note)
                        .onSubmit {
                            focusedField = nil
                        }
                }
                .fixedSize(horizontal: true, vertical: false)
                
                if transactionSelected == TransactionType.expense.rawValue {
                    CustomSpacer(height: 70)
                    
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
                    CustomSpacer(height: 132)
                }
                
                
                CustomButton(
                    text: "Create",
                    isDisabled: false,
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
            self.focusedField = .receiverSender
        }
    }
}

#Preview {
    AddTransactionView(
        user: UserModel(),
        senderReceiverText: .constant(""),
        priceText: .constant(""),
        noteText: .constant(""),
        transactionSelected: .constant(""),
        senderReceiverPlaceholder: .constant("Receiver"),
        onCategoryDropdownItemClicked: {_ in },
        onCreateTransactionButtonClicked: {}
    )
}
