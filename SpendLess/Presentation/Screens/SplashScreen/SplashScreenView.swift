//
//  ContentView.swift
//  SpendLess
//
//  Created by Andres Cordón on 18/2/25.
//

import SwiftUI

struct SplashScreenView: View {
    
    @State private var viewModel: SplashScreenViewModel = SplashScreenViewModel()
    @State private var path: [Views] = []
    
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
            .navigationDestination(for: Views.self) { screen in
                switch screen {
                case .UsernameView:
                    UsernameView(path: $path)
                case .CreatePinView:
                    CreatePinView(path: $path)
                case .RepeatPinView:
                    RepeatPinView(path: $path)
                case .OnboardingPreferencesView:
                    OnboardingPreferencesView(path: $path)
                case .LoginView:
                    LoginView(path: $path)
                case .DashboardView:
                    DashboardView(path: $path)
                case .AllTransactionsView:
                    AllTransactionsView(path: $path)
                case .SettingsView:
                    SettingsView(path: $path)
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
