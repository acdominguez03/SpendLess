//
//  TransactionSelector.swift
//  SpendLess
//
//  Created by Andres Cordón on 11/2/25.
//

import SwiftUI

struct TransactionSelector: View {
    @Binding var valueSelected: String
    
    let icons: [String] = ["Expenses", "Income"]
    var values: [String] = ["Expense", "Income"]
    
    var onValueSelectorClicked: (String) -> Void = {_ in}
    
    var body: some View {
        VStack(alignment: .leading) {
            
            HStack(spacing: 0) {
                ForEach(Array(values.enumerated()), id: \.offset) { index, value in
                    ZStack {
                        Rectangle()
                            .fill(Color("PrimaryContainer").opacity(0.08))
                        
                        Rectangle()
                            .fill(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .padding(4)
                            .opacity(valueSelected == value ? 1 : 0.01)
                            .onTapGesture {
                                withAnimation(.interactiveSpring()) {
                                    valueSelected = value
                                    onValueSelectorClicked(value)
                                }
                            }
                    }.overlay {
                        HStack(spacing: 7.5) {
                            if !icons.isEmpty {
                                Image(icons[index])
                                    .renderingMode(.template)
                                    .frame(width: 15, height: 9)
                                    .foregroundStyle(valueSelected == value ? Color("PrimaryApp") : Color("OnPrimaryFixed"))
                            }
                            
                            Text(value)
                                .modifier(TitleMedium(color: valueSelected == value ? Color("PrimaryApp") : Color("OnPrimaryFixed")))
                        }
                    }
                }
            }
            .frame(height: 48)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .onAppear {
                valueSelected = values[0]
            }
        }
    }
}

#Preview {
    TransactionSelector(valueSelected: .constant(""))
}
