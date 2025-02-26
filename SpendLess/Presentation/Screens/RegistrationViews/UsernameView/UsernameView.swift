//
//  RegistrationUsernameView.swift
//  SpendLess
//
//  Created by Andres Cordón on 4/2/25.
//

import SwiftUI

struct UsernameView: View {
    @Binding var path: [Views]
    @State var viewModel: UsernameViewModel = UsernameViewModel()
    @FocusState private var isTextFieldFocused: Bool
    
    var body: some View {
        VStack {
            AppIcon()
            
            Spacer().frame(height: 20)
            
            Text("Welcome to SpendLess! How can we address you?")
                .modifier(HeadlineMedium(color: Color("OnSurface")))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 26)
            
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
                    .autocorrectionDisabled(true)
                    .textInputAutocapitalization(.never)
                    .focused($isTextFieldFocused)
                    .onSubmit {
                        isTextFieldFocused = false
                        Task {
                            await viewModel.checkUsername()
                        }
                    }
            }
            .padding(.horizontal, 26)
            
            Spacer().frame(height: 16)
            
            CustomButton(
                text: "Next",
                icon: "arrow.right",
                isDisabled: viewModel.username.isEmpty,
                onClick: {
                    isTextFieldFocused = false
                    Task {
                        await viewModel.checkUsername()
                    }
                }
            )
            .padding(.horizontal, 26)
            
            Spacer().frame(height: 40)
            
            Button {
                path.append(Views.LoginView)
            } label: {
                Text("Already have an account?")
                    .modifier(TitleMedium(color: Color("PrimaryApp")))
            }
            
            Spacer()
            
            if viewModel.showError {
                Banner(showError: $viewModel.showError , error: viewModel.errorMessage)
                    .KeyboardAwarePadding()
                    .animation(.easeInOut, value: isTextFieldFocused)
            }
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .ignoresSafeArea(edges: .bottom)
        .padding(.top, 36)
        .background(Color("Background"))
        .navigationBarBackButtonHidden()
        .onTapGesture {
            isTextFieldFocused = false
        }
        .onAppear {
            viewModel.path = $path
        }
        .onDisappear {
            DispatchQueue.main.async {
                viewModel.reset()
            }
        }
    }
}

#Preview {
    UsernameView(path: .constant([]))
}
