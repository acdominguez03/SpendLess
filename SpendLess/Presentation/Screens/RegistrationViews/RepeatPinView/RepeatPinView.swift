//
//  RepeatPinView.swift
//  SpendLess
//
//  Created by Andres Cordón on 5/2/25.
//

import SwiftUI

struct RepeatPinView: View {
    @Binding var path: [Screen]
    @State var viewModel: RepeatPinViewModel = RepeatPinViewModel()
    
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
            
            Text("Repeat your PIN")
                .modifier(HeadlineMedium())
                .foregroundStyle(Color("OnSurface"))
            
            Spacer().frame(height: 8)
            
            Text("Enter your PIN again")
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
            
            if viewModel.showError {
                Banner(error: "Pins don´t match. Try again")
                    .padding(.bottom, 24)
            }
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .ignoresSafeArea(edges: .bottom)
        .background(Color("Background"))
        .navigationBarBackButtonHidden()
        .onAppear {
            viewModel.path = $path
        }
    }
}

#Preview {
    RepeatPinView(path: .constant([]))
}
