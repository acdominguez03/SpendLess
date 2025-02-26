//
//  EmptyTransactionsView.swift
//  SpendLess
//
//  Created by Andres Cordón on 21/2/25.
//

import SwiftUI

struct EmptyTransactionsView: View {
    var body: some View {
        VStack {
            Spacer()
            
            Image("Money")
                .resizable()
                .scaledToFit()
                .frame(width: 96, height: 96)
                .padding(.bottom, 13)
            
            Text("No transactions to show")
                .modifier(TitleLarge(color: Color("OnSurface")))
                .frame(maxWidth: .infinity)
            
            Spacer()
        }
    }
}

#Preview {
    EmptyTransactionsView()
}
