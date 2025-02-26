//
//  PreviousWeekSpentView.swift
//  SpendLess
//
//  Created by Andres Cordón on 20/2/25.
//

import SwiftUI

struct TotalExpensesForThePastWeekView: View {
    @Binding var totalSpending: Double
    let currency: Currency
    let decimalSeparator: DecimalSeparator
    let thousandSeparator: ThousandsSeparator
    let expensesFormat: ExpensesFormat
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(Utils.shared.formatNumberWithUserSettings(amount: totalSpending, currency: currency, decimalSeparator: decimalSeparator, thousandSeparator: thousandSeparator, expensesFormat: expensesFormat))
                .modifier(TitleLarge(color: Color("OnSurface")))
                .multilineTextAlignment(.leading)
            
            
            Text("Previous week")
                .modifier(BodyXSmall(color: Color("OnSurface").opacity(0.7)))
                .multilineTextAlignment(.leading)
        }
        .frame(width: UIScreen.main.bounds.width * 0.3)
        .padding(.vertical, 12)
        .background(Color("SecondaryFixed"))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

#Preview {
    TotalExpensesForThePastWeekView(
        totalSpending: .constant(10.0),
        currency: Currency.dollar,
        decimalSeparator: DecimalSeparator.comma,
        thousandSeparator: ThousandsSeparator.comma,
        expensesFormat: ExpensesFormat.less
    )
}
