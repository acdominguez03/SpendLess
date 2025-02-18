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
    
    let user: UserModel
    
    var body: some View {
        GeometryReader { geometryReader in
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
                            user: user,
                            senderReceiverText: $viewModel.transceiverText,
                            priceText: $viewModel.priceText,
                            noteText: $viewModel.noteText,
                            transactionSelected: $viewModel.transactionSelected,
                            senderReceiverPlaceholder: $viewModel.senderReceiverPlaceholder,
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
                    .frame(height: geometryReader.size.height - 60)
                    .background(
                        Color("SurfaceContainer")
                            .clipShape(.rect(topLeadingRadius: 28, topTrailingRadius: 28))
                    )
                    .transition(.opacity.combined(with: .move(edge: .bottom)))
                    
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            .ignoresSafeArea()
            .animation(.easeInOut, value: isShowing)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    AddTransactionBottomSheet(isShowing: .constant(true), user: UserModel())
}
