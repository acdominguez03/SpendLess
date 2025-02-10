//
//  DashboardView.swift
//  SpendLess
//
//  Created by Andres Cordón on 10/2/25.
//

import SwiftUI

struct DashboardView: View {
    @Binding var path: [Screen]
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    DashboardView(path: .constant([]))
}
