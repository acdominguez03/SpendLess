//
//  CustomButton.swift
//  SpendLess
//
//  Created by Andres Cordón on 4/2/25.
//

import SwiftUI

struct CustomButton: View {
    var text: String = "Next"
    var icon: String = ""
    var isDisabled: Bool = true
    var onClick: () -> Void = {}
    
    var body: some View {
        Button {
            onClick()
        } label: {
            HStack(spacing: 8) {
                Text(text)
                    .modifier(TitleMedium(color: isDisabled ? Color("OnSurface").opacity(0.38) : .white))
                if !icon.isEmpty {
                    Image(systemName: icon)
                        .frame(width: 18, height: 18)
                        .tint(isDisabled ? Color("OnSurface").opacity(0.38) : .white)
                }
            }.frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .background(isDisabled ? Color("OnSurface").opacity(0.12) : Color("PrimaryApp"))
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .disabled(isDisabled)
        }
    }
}

#Preview {
    CustomButton()
}
