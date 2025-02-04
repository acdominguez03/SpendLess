//
//  Banner.swift
//  SpendLess
//
//  Created by Andres Cordón on 4/2/25.
//

import SwiftUI

struct Banner: View {
    let isError: Bool = true
    let error: String = "This username has already been taken"
    
    var body: some View {
        Text(error)
            .containerRelativeFrame(.horizontal)
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
            .background(isError ? Color("Error") : Color("Success"))
            .foregroundStyle(Color.white)
    }
}

#Preview {
    Banner()
}
