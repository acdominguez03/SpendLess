//
//  CreatePinView.swift
//  SpendLess
//
//  Created by Andres Cordón on 4/2/25.
//

import SwiftUI

struct CreatePinView: View {
    @Binding var path: [Screen]
    @State var viewModel: CreatePinViewModel = CreatePinViewModel()
    
    var body: some View {
        VStack {
            ZStack(alignment: .top) {
                BackButton {
                    viewModel.backButtonPressed()
                }

                AppIcon()
                    .padding(.top, 28)
            }
            
            Spacer().frame(height: 20)
            
            Text("Create PIN")
                .modifier(HeadlineMedium())
                .foregroundStyle(Color("OnSurface"))
            
            Spacer().frame(height: 8)
            
            Text("Use PIN to login to your account")
                .modifier(BodyMedium(color: Color("OnSurfaceVariant")))
            
            Spacer().frame(height: 36)
            
            PinKeyboard(
                onClickNumberButton: { number in
                    viewModel.updatePin(newValue: number)
                },
                onClickDeleteButton: {
                    viewModel.eliminateLastPinDigit()
                },
                pin: viewModel.pin
            )
                
            Spacer()
        }
        .background(Color("Background"))
        .navigationBarBackButtonHidden()
        .onAppear {
            viewModel.path = $path
        }
        .onDisappear {
            viewModel.reset()
        }
    }
}

#Preview {
    CreatePinView(path: .constant([]))
}
