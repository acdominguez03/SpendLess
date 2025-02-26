//
//  LargestTransactionView.swift
//  SpendLess
//
//  Created by Andres Cordón on 20/2/25.
//

import SwiftUI

struct LargestTransactionView: View {
    @Binding var transaction: TransactionModel?
    let currency: Currency
    let expensesFormat: ExpensesFormat
    let decimalSeparator: DecimalSeparator
    let thousandSeparator: ThousandsSeparator
    
    var body: some View {
        if transaction != nil {
            HStack {
                VStack(alignment: .leading) {
                    Text(transaction!.transceiver)
                        .modifier(TitleLarge(color: Color("OnSurface")))
                    Text("Largest transaction")
                        .modifier(BodyXSmall(color: Color("OnSurface").opacity(0.7)))
                }
                
                VStack(alignment: .trailing) {
                    Text(Utils.shared.formatTransactionAmount(
                        transaction: transaction!,
                        currency: currency,
                        decimalSeparator: decimalSeparator,
                        thousandSeparator: thousandSeparator,
                        expensesFormat: expensesFormat)
                    )
                    .modifier(TitleLarge(color: Color("OnSurface")))
                    
                    Text(transaction!.date.dateToString())
                        .modifier(BodyXSmall(color: Color("OnSurface").opacity(0.7)))
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .background(Color("PrimaryFixed"))
            .clipShape(RoundedRectangle(cornerRadius: 16))
        } else {
            Text("Your largest transaction will\nappear here")
                .modifier(TitleMedium(color: Color("OnSurface")))
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)
                .padding(.vertical, 12)
                .background(Color("PrimaryFixed"))
                .clipShape(RoundedRectangle(cornerRadius: 16))
        }
        
    }
}

#Preview {
    LargestTransactionView(
        transaction: .constant(nil),
        currency: Currency.dollar,
        expensesFormat: ExpensesFormat.less,
        decimalSeparator: DecimalSeparator.comma,
        thousandSeparator: ThousandsSeparator.comma
    )
}
