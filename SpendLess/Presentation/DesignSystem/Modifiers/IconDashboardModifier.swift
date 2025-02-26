//
//  IconDashboardModifier.swift
//  SpendLess
//
//  Created by Andres Cordón on 18/2/25.
//

import SwiftUI

extension Image {
    func iconDashboardModifier() -> some View {
        self
            .renderingMode(.template)
            .resizable()
            .scaledToFit()
            .frame(width: 16, height: 16)
            .foregroundStyle(Color.white)
            .padding(14)
            .background(
                Color("OnPrimary").opacity(0.12)
            )
            .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}
