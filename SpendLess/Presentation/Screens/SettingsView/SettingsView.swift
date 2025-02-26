//
//  SettingsView.swift
//  SpendLess
//
//  Created by Andres Cordón on 26/2/25.
//

import SwiftUI

struct SettingsView: View {
    @Binding var path: [Views]
    
    @State private var viewModel: SettingsViewModel = SettingsViewModel()
    
    var body: some View {
        VStack(spacing: 8) {
            HStack(spacing: 12) {
                Button {
                    path.removeLast()
                } label: {
                    Image("LeftArrow")
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 16, height: 16)
                        .foregroundStyle(Color("OnSurface"))
                        .padding(4)
                }
                
                Text("Settings")
                    .modifier(TitleLarge(color: Color("OnSurface")))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            CustomSpacer(height: 8)
            
            VStack {
                HStack(spacing: 8) {
                    Image("Gear")
                        .padding(10)
                        .background(Color("SurfaceContainerLow"))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    
                    Text("Preferences")
                        .modifier(LabelMedium(color: Color("OnSurface")))
                    
                    Spacer()
                }
                
                HStack(spacing: 8) {
                    Image("Lock")
                        .padding(10)
                        .background(Color("SurfaceContainerLow"))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    
                    Text("Security")
                        .modifier(LabelMedium(color: Color("OnSurface")))
                    
                    Spacer()
                }
            }
            .padding(4)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .shadow(color: Color("Shadow"), radius: 16, y: 8)
            
            HStack(spacing: 8) {
                Image("LogOut")
                    .renderingMode(.template)
                    .foregroundStyle(Color("Error"))
                    .padding(10)
                    .background(Color("Error").opacity(0.08))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                
                Text("Log Out")
                    .modifier(LabelMedium(color: Color("Error")))
                
                Spacer()
            }
            .padding(4)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .shadow(color: Color("Shadow"), radius: 16, y: 8)
            .onTapGesture {
                Task {
                    await viewModel.logOut()
                }
            }
            
            Spacer()
        }
        .padding(.top, 8)
        .padding(.horizontal, 16)
        .background(Color("Background"))
        .navigationBarBackButtonHidden()
        .onAppear {
            viewModel.path = $path
        }
    }
}

#Preview {
    SettingsView(path: .constant([]))
}
