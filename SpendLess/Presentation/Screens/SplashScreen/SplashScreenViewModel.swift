//
//  Untitled.swift
//  SpendLess
//
//  Created by Andres Cordón on 19/2/25.
//

import Foundation
import SwiftUI

@Observable
@MainActor final class SplashScreenViewModel {
    var path: Binding<[Views]>?
    let getLoggedUserUseCase: GetLoggedUserUseCase
    
    init() {
        self.getLoggedUserUseCase = GetLoggedUserUseCase(repository: UserRepositoryImpl.shared)
    }
    
    func checkIfOneUserIsLogged() async {
        let result = await getLoggedUserUseCase.execute()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            switch result {
            case .success(let user):
                if (user != nil) {
                    self.navigateToDashboardView()
                } else {
                    self.navigateToUsernameView()
                }
            case .failure(let error):
                self.navigateToUsernameView()
                print(error)
            }
        }
    }
    
    func navigateToDashboardView() {
        path?.wrappedValue.append(Views.DashboardView)
    }
    
    func navigateToUsernameView() {
        path?.wrappedValue.append(Views.UsernameView)
    }
}
