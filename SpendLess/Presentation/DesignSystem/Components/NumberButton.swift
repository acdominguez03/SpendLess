//
//  NumberButton.swift
//  SpendLess
//
//  Created by Andres Cordón on 5/2/25.
//

import SwiftUI

struct NumberButton: View {
    var number: String = "1"
    var onClick: () -> Void = {}
    
    var body: some View {
        Button {
            withAnimation {
                onClick()
            }
        } label: {
            Text(number)
                .modifier(HeadlineLarge(color: Color("OnPrimaryFixed")))
                .frame(width: 108, height: 108)
                .background(Color("PrimaryFixed"))
                .clipShape(RoundedRectangle(cornerRadius: 32))
        }
    }
}

#Preview {
    NumberButton()
}
