//
//  Banner.swift
//  SpendLess
//
//  Created by Andres Cordón on 4/2/25.
//

import SwiftUI

struct Banner: View {
    @Binding var showError: Bool
    var isError: Bool = true
    var error: String
    
    var body: some View {
        Text(error)
            .containerRelativeFrame(.horizontal)
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
            .background(isError ? Color("Error") : Color("Success"))
            .foregroundStyle(Color.white)
            .transition(.move(edge: .bottom))
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation(.easeOut) {
                        showError = false
                    }
                }
            }
    }
}

#Preview {
    Banner(showError: .constant(false), error: "This username has already been taken")
}
