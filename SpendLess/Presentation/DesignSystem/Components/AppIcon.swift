//
//  AppIcon.swift
//  SpendLess
//
//  Created by Andres Cordón on 4/2/25.
//

import SwiftUI

struct AppIcon: View {
    var body: some View {
        Image("WalletMoney")
            .padding(17)
            .background(Color("PrimaryContainer"))
            .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

#Preview {
    AppIcon()
}
