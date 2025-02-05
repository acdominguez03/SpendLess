//
//  CreatePinView.swift
//  SpendLess
//
//  Created by Andres Cordón on 4/2/25.
//

import SwiftUI

struct CreatePinView: View {
    @Binding var path: NavigationPath
    
    var body: some View {
        VStack {
            
            Image("LeftArrow")
                .padding(.leading, 16)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            AppIcon()
            
            Spacer()
            
        }
        .frame(maxWidth: .infinity)
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .ignoresSafeArea(edges: .bottom)
        .padding(.top, 28)
        .background(Color("Background"))
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    CreatePinView(path: .constant(NavigationPath()))
}
