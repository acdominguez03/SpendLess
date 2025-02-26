//
//  BottomSheetView.swift
//  SpendLess
//
//  Created by Andres Cordón on 11/2/25.
//

import SwiftUI

struct AddTransactionBottomSheet: View {
    @State var viewModel: AddTransactionBottomSheetViewModel = AddTransactionBottomSheetViewModel()
    @Binding var isShowing: Bool
    
    var body: some View {
        ZStack(alignment: .bottom) {
            if isShowing {
                Color.black
                    .opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        isShowing = false
                    }
                
                VStack {
                    HStack {
                        Text("Create Transaction")
                            .modifier(TitleLarge(color: Color("OnSurface")))
                            .padding(.leading, 16)
                        
                        Spacer()
                        
                        Button {
                            isShowing = false
                        } label: {
                            Image(systemName: "xmark")
                                .frame(width: 14, height: 14)
                                .frame(width: 48, height: 48)
                                .tint(Color("OnSurface"))
                        }
                        .padding(.trailing, 4)
                        
                    }
                    .padding(.top, 20)
                    
                    CustomSpacer(height: 16)
                    
                    TransactionSelector(
                        valueSelected: .constant(viewModel.transactionSelected),
                        values: [
                            TransactionType.expense.rawValue,
                            TransactionType.income.rawValue,
                        ],
                        onValueSelectorClicked: { value in
                            viewModel.onValueSelectorCLicked(value: value)
                        }
                    )
                    .padding(.horizontal, 16)
                    
                    CustomSpacer(height: 34)
                    
                    AddTransactionView(
                        user: viewModel.user,
                        transceiverText: $viewModel.transceiverText,
                        amountText: $viewModel.amountText,
                        noteText: $viewModel.noteText,
                        transactionSelected: $viewModel.transactionSelected,
                        transceiverPlaceholder: $viewModel.senderReceiverPlaceholder,
                        expensesFormat: viewModel.user.expensesFormat,
                        onCategoryDropdownItemClicked: { value in
                            viewModel.onCategoryDropdownMenuItemClicked(value: value)
                        },
                        onCreateTransactionButtonClicked: {
                            Task {
                                await viewModel.addTransaction {
                                    isShowing = false
                                }
                            }
                        }
                    )
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .frame(height: UIScreen.main.bounds.height - 60)
                .background(Color("SurfaceContainer") )
                
                if viewModel.showError {
                    Banner(showError: $viewModel.showError , error: viewModel.errorMessage)
                        .KeyboardAwarePadding()
                        .animation(.easeInOut, value: isShowing)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .ignoresSafeArea(.all)
        .animation(.easeInOut, value: isShowing)
        .onTapGesture {
            hideKeyboard()
        }
        .onAppear {
            Task {
                await viewModel.getUserData()
            }
        }
    }
}

#Preview {
    AddTransactionBottomSheet(isShowing: .constant(true))
}
