//
//  DeleteButton.swift
//  SpendLess
//
//  Created by Andres Cordón on 5/2/25.
//

import SwiftUI

struct DeleteButton: View {
    var onClick: () -> Void = {}
    
    var body: some View {
        Button {
            onClick()
        } label: {
            ZStack(alignment: .center) {
                Image("Delete")
            }
            .frame(width: 108, height: 108)
            .background(Color("PrimaryFixed").opacity(0.3))
            .clipShape(RoundedRectangle(cornerRadius: 32))
        }
    }
}

#Preview {
    DeleteButton()
}
