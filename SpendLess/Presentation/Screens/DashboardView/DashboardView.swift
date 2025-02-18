//
//  DashboardView.swift
//  SpendLess
//
//  Created by Andres Cordón on 10/2/25.
//

import SwiftUI


struct DashboardView: View {
    @State var isShowingBottomSheet: Bool = false
    @State var viewModel: DashboardViewModel = DashboardViewModel()
    
    @Binding var path: [Screen]
    
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color("PrimaryApp"), Color("OnPrimaryFixed")],
                startPoint: .leading,
                endPoint: .trailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 0) {
                VStack {
                    HStack {
                        Text(UserDefaultsManager.shared.username ?? "")
                            .modifier(TitleLarge(color: .white))
                        
                        Spacer()
                        
                        Button {
                            
                        } label: {
                            Image("Settings")
                                .renderingMode(.template)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                                .foregroundStyle(.white)
                                .padding(10)
                                .background(
                                    Color("OnPrimary").opacity(0.12)
                                )
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                        }
                    }
                    .padding(.horizontal, 16)
                    
                    CustomSpacer(height: 38)
                    
                    Text(viewModel.accountBalanceString)
                        .modifier(DisplayLarge(color: .white))
                    
                    Text("Account Balance")
                        .modifier(BodySmall(color: Color("OnPrimary").opacity(0.8)))
                    
                    CustomSpacer(height: 38)
                }
                
                VStack(alignment: .trailing) {
                    
                    HStack(alignment: .center) {
                        Text("Latest Transactions")
                            .modifier(TitleLarge(color: Color("OnSurface")))
                        
                        Spacer()
                        
                        Button {
                            path.append(Screen.AllTransactionsScreen)
                        } label: {
                            Text("Show all")
                                .modifier(TitleMedium(color: Color("PrimaryApp")))
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 27)
                    
                    CustomSpacer(height: 15)
                    
                    LazyVStack {
                        ForEach(viewModel.transactions) { transaction in
                            if let currency = viewModel.user?.currency {
                                TransactionCellView(transaction: transaction, currency: currency)
                            }
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
            .padding(.bottom, 40)
            
            AddTransactionBottomSheet(
                isShowing: $isShowingBottomSheet,
                user: viewModel.user ?? UserModel()
            )
        }
        .navigationBarBackButtonHidden()
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
    DashboardView(path: .constant([]))
}
