//
//  DashboardView.swift
//  SpendLess
//
//  Created by Andres Cordón on 10/2/25.
//

import SwiftUI
import Combine


struct DashboardView: View {
    @State var isShowingBottomSheet: Bool = false
    @State var viewModel: DashboardViewModel = DashboardViewModel()
    
    @State private var currentTransaction: Int = 0
    @State private var isScrolling: Bool = false
    
    @Binding var path: [Views]
    
    var body: some View {
        ZStack(alignment: .bottom) {
            RadialGradient(
                colors: [Color("PrimaryApp"), Color("OnPrimaryFixed")],
                center: .topLeading,
                startRadius: 100,
                endRadius: 500
            )
            .ignoresSafeArea()
            
            VStack(spacing: 0) {
                VStack {
                    HStack(spacing: 12) {
                        Text(UserDefaultsManager.shared.username ?? "")
                            .modifier(TitleLarge(color: .white))
                        
                        Spacer()
                        
                        Button {
                            //Ir a upload
                        } label: {
                            Image("Upload")
                                .iconDashboardModifier()
                        }
                        
                        
                        Button {
                            viewModel.navigateToSettings()
                        } label: {
                            Image("Settings")
                                .iconDashboardModifier()
                        }
                    }
                    .padding(.horizontal, 16)
                    
                    CustomSpacer(height: 38)
                    
                    Text(viewModel.accountBalanceString)
                        .modifier(DisplayLarge(color: .white))
                    
                    Text("Account Balance")
                        .modifier(BodySmall(color: Color("OnPrimary").opacity(0.8)))
                    
                    CustomSpacer(height: 38)
                    
                    CategoryWithTheHighestSpendingView(category: $viewModel.categoryWithTheHighestSpending)
                        .opacity(viewModel.transactions.isEmpty ? 0.0 : 1.0)
                    
                    CustomSpacer(height: 8)
                    
                    HStack(spacing: 12) {
                        LargestTransactionView(
                            transaction: $viewModel.largestTransaction,
                            currency: viewModel.currency,
                            expensesFormat: viewModel.expensesFormat,
                            decimalSeparator: viewModel.decimalSeparator,
                            thousandSeparator: viewModel.thousandSeparator
                        )
                        
                        TotalExpensesForThePastWeekView(
                            totalSpending: $viewModel.totalExpensesForTheWeek,
                            currency: viewModel.currency,
                            decimalSeparator: viewModel.decimalSeparator,
                            thousandSeparator: viewModel.thousandSeparator,
                            expensesFormat: viewModel.expensesFormat
                        )
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 16)
                    
                    CustomSpacer(height: 16)
                }
                
                VStack(alignment: .center) {
                    
                    if viewModel.transactions.isEmpty {
                        EmptyTransactionsView()
                    } else {
                        HStack(alignment: .center) {
                            Text("Latest Transactions")
                                .modifier(TitleLarge(color: Color("OnSurface")))
                            
                            Spacer()
                            
                            Button {
                                path.append(Views.AllTransactionsView)
                            } label: {
                                Text("Show all")
                                    .modifier(TitleMedium(color: Color("PrimaryApp")))
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.top, 27)
                        
                        CustomSpacer(height: 15)
                        
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
                                            .padding(.top, 8)
                                            .padding(.bottom, 4)
                                            .padding(.horizontal, 16)
                                            .background(Color("Background"))
                                    }
                                }
                            }
                            .padding(.bottom, 8)
                        }
                    }
                }
                .frame(maxHeight: .infinity, alignment: .top)
                .background(
                    Color("Background")
                        .clipShape(.rect(topLeadingRadius: 28, topTrailingRadius: 28))
                )
                .ignoresSafeArea(edges: .bottom)
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
            
            
        }
        .sheet(isPresented: $isShowingBottomSheet, content: {
            AddTransactionBottomSheet(isShowing: $isShowingBottomSheet)
        })
        .navigationBarBackButtonHidden()
        .onAppear {
            viewModel.path = $path
            Task {
                await viewModel.getUserData()
                await viewModel.getTransactions()
            }
        }
        .onChange(of: isShowingBottomSheet, { oldValue, newValue in
            if(!newValue) {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    Task {
                        await viewModel.getTransactions()
                    }
                }
            }
        })
    }
}
