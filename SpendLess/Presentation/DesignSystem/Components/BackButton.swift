//
//  BackTopBar.swift
//  SpendLess
//
//  Created by Andres Cordón on 5/2/25.
//

import SwiftUI

struct BackButton: View {
    var onClick: () -> Void = {}
    
    var body: some View {
        Button {
            onClick()
        } label: {
            Image("LeftArrow")
                .padding(.leading, 20)
                .padding(.top, 24)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

#Preview {
    BackButton()
}
