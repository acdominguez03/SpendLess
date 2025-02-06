//
//  FaceIdButton.swift
//  SpendLess
//
//  Created by Andres Cordón on 5/2/25.
//

import SwiftUI

struct FaceIdButton: View {
    var body: some View {
        Image(systemName: "faceid")
            .resizable()
            .scaledToFit()
            .frame(width: 40, height: 40)
            .padding(34)
            .background(Color("PrimaryFixed").opacity(0.3))
            .clipShape(RoundedRectangle(cornerRadius: 32))
    }
}

#Preview {
    FaceIdButton()
}
