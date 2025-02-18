//
//  AllTransactionsView.swift
//  SpendLess
//
//  Created by Andres Cordón on 16/2/25.
//

import SwiftUI

struct AllTransactionsView: View {
    @State private var viewModel: AllTransactionsViewModel = AllTransactionsViewModel()
    
    @Binding var path: [Screen]
    
    var body: some View {
        VStack {
            HStack(spacing: 16) {
                Button {
                    path.removeLast()
                } label: {
                    Image("LeftArrow")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 16, height: 16)
                }
                
                Text("All Transactions")
                    .modifier(TitleLarge(color: Color("OnSurface")))
                
                Spacer()
            }
            .padding(.leading, 20)
            .padding(.vertical, 8)
            
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.transactions) { transaction in
                        TransactionCellView(
                            transaction: transaction,
                            currency: viewModel.currency
                        )
                    }
                }
                .frame(maxHeight: .infinity)
                
                Spacer()
            }
        }
        .navigationBarBackButtonHidden()
        .onAppear {
            viewModel.path = $path
            Task {
                await viewModel.getUserData()
                await viewModel.getTransactions()
            }
        }
    }
}

#Preview {
    AllTransactionsView(path: .constant([]))
}
