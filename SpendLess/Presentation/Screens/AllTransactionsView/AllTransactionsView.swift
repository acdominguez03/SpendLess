//
//  AllTransactionsView.swift
//  SpendLess
//
//  Created by Andres Cordón on 16/2/25.
//

import SwiftUI

struct AllTransactionsView: View {
    @State var isShowingBottomSheet: Bool = false
    @State private var viewModel: AllTransactionsViewModel = AllTransactionsViewModel()
    
    @Binding var path: [Views]
    
    var body: some View {
        ZStack {
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
                    LazyVStack(spacing: 0, pinnedViews: [.sectionHeaders]) {
                        ForEach(Utils.shared.groupAndSortByDay(transactions: viewModel.transactions), id: \.0) { (date, transactions) in
                            Section {
                                ForEach(transactions) { transaction in
                                    TransactionCellView(
                                        transaction: transaction,
                                        currency: viewModel.currency,
                                        decimalSeparator: viewModel.decimalSeparator,
                                        thousandSeparator: viewModel.thousandSeparator,
                                        expensesFormat: viewModel.expensesFormat
                                    )
                                    .padding(.vertical, 4)
                                }
                            } header: {
                                Text(date.toTodayYesterdayOrDate(format: "MMMM d"))
                                    .modifier(BodyXSmall(color: Color("OnSurface").opacity(0.7)))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.horizontal, 16)
                                    .padding(.bottom, 12)
                                    .background(Color("Background"))
                            }
                        }
                    }
                    .padding(.bottom, 8)
                    
                    Spacer()
                }
            }
            .background(Color("Background"))
            .navigationBarBackButtonHidden()
            .onAppear {
                viewModel.path = $path
                Task {
                    await viewModel.getUserData()
                    await viewModel.getTransactions()
                }
            }
            
            Button {
                isShowingBottomSheet = true
            } label: {
                Image(systemName: "plus")
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 16, height: 16)
                    .foregroundStyle(Color("OnSecondaryContainer"))
                    .padding(22)
                    .background(Color("SecondaryContainer"))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .shadow(color: Color("Shadow"), radius: 24, x: 0, y: 8)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .frame(maxHeight: .infinity, alignment: .bottom)
            .padding(.trailing, 26)
            .padding(.bottom, 16)
            
            AddTransactionBottomSheet(isShowing: $isShowingBottomSheet)
        }
        .onAppear {
            viewModel.path = $path
            Task {
                await viewModel.getUserData()
                await viewModel.getTransactions()
            }
        }
        .onChange(of: isShowingBottomSheet, { oldValue, newValue in
            if(newValue == false) {
                Task {
                    await viewModel.getTransactions()
                }
            }
        })
    }
}

#Preview {
    AllTransactionsView(path: .constant([]))
}
