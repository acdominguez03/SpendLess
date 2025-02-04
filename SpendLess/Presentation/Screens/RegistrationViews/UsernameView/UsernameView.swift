//
//  RegistrationUsernameView.swift
//  SpendLess
//
//  Created by Andres Cordón on 4/2/25.
//

import SwiftUI

struct UsernameView: View {
    @State var viewModel: UsernameViewModel = UsernameViewModel()
    @FocusState private var isTextFieldFocused: Bool
    @StateObject private var keyboardObserver = KeyboardObserver()
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                AppIcon()
                
                Spacer().frame(height: 20)
                
                Text("Welcome to SpendLess! How can we address you?")
                    .modifier(HeadlineMedium(color: Color("OnSurface")))
                    .multilineTextAlignment(.center)
                
                Spacer().frame(height: 8)
                
                Text("Create unique username")
                    .modifier(BodyMedium(color: Color("OnSurfaceVariant")))
                
                Spacer().frame(height: 36)
                
                ZStack {
                    if viewModel.username.isEmpty {
                        Text("username")
                            .modifier(DisplayMedium(color: Color("TextfieldUsername")))
                    }
                    
                    TextField("", text: $viewModel.username)
                        .frame(height: 60)
                        .modifier(DisplayMedium(color: Color("OnSurface")))
                        .background(Color("OnBackground").opacity(0.08))
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .multilineTextAlignment(.center)
                        .tint(Color("PrimaryApp"))
                        .textInputAutocapitalization(TextInputAutocapitalization.never)
                        .focused($isTextFieldFocused)
                }
                
                Spacer().frame(height: 16)
                
                CustomButton(
                    text: "Next",
                    icon: "arrow.right",
                    isDisabled: viewModel.username.isEmpty,
                    onClick: {
                        isTextFieldFocused = false
                        viewModel.checkUsername()
                    }
                )
                
                Spacer().frame(height: 40)
                
                Text("Already have an account?")
                    .modifier(TitleMedium(color: Color("PrimaryApp")))
                
                Spacer()
                
                if viewModel.showError {
                    Banner(error: viewModel.errorMessage)
                        .padding(.bottom, 24)
                        .offset(y: isTextFieldFocused ? -keyboardObserver.keyboardHeight + 24 : 0)
                        .animation(.easeInOut, value: isTextFieldFocused)
                }
            }
            .ignoresSafeArea(.keyboard, edges: .bottom)
            .ignoresSafeArea(edges: .bottom)
            .padding(.top, 36)
            .padding(.horizontal, 26)
            .background(Color("Background"))
            .onTapGesture {
                isTextFieldFocused = false
            }
            .navigationDestination(isPresented: $viewModel.navigateToPinScreen) {
                CreatePinView(path: $path)
            }
        }
    }
}

#Preview {
    UsernameView(viewModel: UsernameViewModel())
}
