//
//  ContentView.swift
//  SpendLess
//
//  Created by Andres Cordón on 18/2/25.
//

import SwiftUI

struct SplashScreenView: View {
    
    @State private var viewModel: SplashScreenViewModel = SplashScreenViewModel()
    @State private var path: [Screen] = []
    
    @State private var blurAmount: CGFloat = 10.0
    @State private var opacity: Double = 0.0
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                Color("Background")
                
                VStack {
                    Image("GeneralIcon")
                        .blur(radius: blurAmount)
                        .opacity(opacity)
                        .onAppear {
                            withAnimation(.easeOut(duration: 1.0)) {
                                blurAmount = 0.0
                                opacity = 1.0
                            }
                        }
                    
                    ProgressView()
                        .padding(.top, 20)
                }
            }
            .navigationDestination(for: Screen.self) { screen in
                switch screen {
                case .UsernameScreen:
                    UsernameView(path: $path)
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
                Task {
                    await viewModel.checkIfOneUserIsLogged()
                }
            }
        }
    }
}

#Preview {
    SplashScreenView()
}
