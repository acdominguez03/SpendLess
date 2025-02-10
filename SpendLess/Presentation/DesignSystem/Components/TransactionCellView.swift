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
    @State var showNote: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(spacing: 8){
                ZStack(alignment: .bottomTrailing) {
                    Image(transaction.category?.icon ?? "Money")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .padding(12)
                        .background(Color("PrimaryFixed"))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    
                    if !transaction.note.isEmpty {
                        Image("Note")
                            .padding(3)
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
                
                let formattedPrice = String(format: "%.2f", transaction.price)
                Text(transaction.category != nil ? "-\(currency.icon)\(formattedPrice)" : "\(currency.icon)\(formattedPrice)")
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
                    .animation(Animation.interpolatingSpring(stiffness: 150, damping: 6), value: showNote)
            }
        }
        .padding(.horizontal, 16)
    }
}

#Preview {
    TransactionCellView(transaction: TransactionModel(transceiver: "Amazon", price: 10.00, note: "Hola buenas", category: nil), currency: Currency.euro)
}
