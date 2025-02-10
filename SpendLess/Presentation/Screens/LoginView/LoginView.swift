//
//  ContentView.swift
//  SpendLess
//
//  Created by Andres Cordón on 3/2/25.
//

import SwiftUI
import SwiftData

enum Field {
    case username, pin
}

struct LoginView: View {
    
    @Binding var path: [Screen]
    
    @State private var viewModel: LoginViewModel = LoginViewModel()
    @FocusState private var focusedField: Field?
    @StateObject private var keyboardObserver = KeyboardObserver()
    
    var body: some View {
        VStack {
            AppIcon()
                .padding(.top, 36)
            
            CustomSpacer(height: 20)
            
            Text("Welcome back!")
                .modifier(HeadlineMedium(color: Color("OnSurface")))
            
            CustomSpacer(height: 8)
            
            Text("Enter your login details")
                .modifier(BodyMedium(color: Color("OnSurfaceVariant")))
            
            CustomSpacer(height: 36)
            
            VStack(spacing: 16) {
                TextField("Username", text: $viewModel.username)
                    .textFieldStyle(LoginTextFieldStyle(isFocused: _focusedField))
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(focusedField == .username ? Color("PrimaryApp") : Color.clear, lineWidth: 2)
                            .fill(.white)
                    )
                    .shadow(color: Color("Shadow"),radius: 20, x: 0, y: 6)
                    .focused($focusedField, equals: .username)
                    .onSubmit {
                        focusedField = .pin
                    }
                
                TextField("PIN", text: $viewModel.pin)
                    .textFieldStyle(LoginTextFieldStyle(isFocused: _focusedField))
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(focusedField == .pin ? Color("PrimaryApp") : Color.clear, lineWidth: 2)
                            .fill(.white)
                    )
                    .shadow(color: Color("Shadow"),radius: 20, x: 0, y: 6)
                    .focused($focusedField, equals: .pin)
                    .onSubmit {
                        focusedField = nil
                        Task {
                            await viewModel.loginUser()
                        }
                    }
                
                CustomButton(
                    text: "Log in",
                    isDisabled: false,
                    onClick: {
                        focusedField = nil
                        Task {
                            await viewModel.loginUser()
                        }
                    }
                ).padding(.top, 8)
                
                CustomSpacer(height: 28)
                
                Button {
                    path.removeLast()
                } label: {
                    Text("New to Spendless?")
                        .modifier(TitleMedium(color: Color("PrimaryApp")))
                }
            }
            Spacer()
            
            if viewModel.showError {
                Banner(error: viewModel.errorMesage)
                    .padding(.bottom, 24)
                    .offset(y: focusedField != nil ? -keyboardObserver.keyboardHeight + 24 : 0)
                    .animation(.easeInOut, value: focusedField)
            }
        }
        .padding(.horizontal, 16)
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .ignoresSafeArea(edges: .bottom)
        .navigationBarBackButtonHidden()
        .background(Color("Background"))
        .onAppear {
            focusedField = .username
            viewModel.path = $path
        }
        .onTapGesture {
            focusedField = nil
        }
    }
}

#Preview {
    LoginView(path: .constant([]))
}
