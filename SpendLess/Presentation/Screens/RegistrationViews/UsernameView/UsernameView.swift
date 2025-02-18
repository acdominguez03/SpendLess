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
    @State private var path: [Screen] = []
    
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
                
                Spacer().frame(height: 40)
                
                Button {
                    path.append(Screen.LoginScreen)
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
            .padding(.horizontal, 26)
            .background(Color("Background"))
            .onTapGesture {
                isTextFieldFocused = false
            }
            .navigationDestination(for: Screen.self) { screen in
                switch screen {
                case .CreatePinScreen:
                    CreatePinView(path: $path)
                case .RepeatPinScreen:
                    RepeatPinView(path: $path)
                case .OnboardingPreferencesScreen:
                    OnboardingPreferencesView(path: $path)
                case .LoginScreen:
                    LoginView(path: $path)
                case .DashboardScreen:
                    DashboardView(path: $path)
                case .AllTransactionsScreen:
                    AllTransactionsView(path: $path)
                }
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
}

#Preview {
    UsernameView()
}
