//
//  TransactionView.swift
//  SpendLess
//
//  Created by Andres Cordón on 16/2/25.
//

import SwiftUI

struct TransactionCellView: View {
    let transaction: TransactionModel
    let currency: Currency
    let decimalSeparator: DecimalSeparator
    let thousandSeparator: ThousandsSeparator
    let expensesFormat: ExpensesFormat
    @State var showNote: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(spacing: 8){
                ZStack(alignment: .bottomTrailing) {
                    Image(transaction.category?.icon ?? "MoneyBag")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .padding(12)
                        .background(transaction.category != nil ? Color("PrimaryFixed") : Color("SecondaryFixed").opacity(0.4))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    
                    if !transaction.note.isEmpty {
                        Image("Note")
                            .renderingMode(.template)
                            .padding(3)
                            .foregroundStyle(transaction.category != nil ? Color("PrimaryApp") :
                                                Color("SecondaryFixedDim"))
                            .background(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 6))
                            .offset(x: 2, y: 2)
                    }
                }
                
                VStack(alignment: .leading, spacing: 0) {
                    Text(transaction.transceiver)
                        .modifier(LabelMedium(color: Color("OnSurface")))
                    
                    Text(transaction.category?.rawValue ?? "Income")
                        .modifier(BodyXSmall(color: Color("OnSurface").opacity(0.7)))
                }
                
                Spacer()
                
                Text(Utils.shared.formatTransactionAmount(
                    transaction: transaction,
                    currency: currency,
                    decimalSeparator: decimalSeparator,
                    thousandSeparator: thousandSeparator,
                    expensesFormat: expensesFormat)
                )
                .modifier(TitleLarge(color: transaction.category != nil  ? Color("OnSurface") : Color("Success")))
            }
            .onTapGesture {
                if transaction.note != "" {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        showNote.toggle()
                    }
                }
            }
            
            if(showNote) {
                Text(transaction.note)
                    .modifier(BodySmall(color: Color("OnSurface")))
                    .padding(.leading, 52)
                    .padding(.bottom, 6)
                    .animation(Animation.interpolatingSpring(stiffness: 150, damping: 6), value: showNote)
            }
        }
        .padding(.vertical, showNote ? 4 : 0)
        .padding(.leading, showNote ? 4 : 0)
        .padding(.trailing, showNote ? 8 : 0)
        .background(
            showNote ? Color.white : Color.clear
        )
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: Color("Shadow"), radius: 16, y: 8)
        .padding(.horizontal, showNote ? 12: 16)
    }
}

#Preview {
    TransactionCellView(transaction: TransactionModel(transceiver: "Amazon", amount: 10.00, note: "hola", category: nil, username: ""), currency: Currency.euro, decimalSeparator: DecimalSeparator.comma, thousandSeparator: ThousandsSeparator.space, expensesFormat: ExpensesFormat.less)
    
}
