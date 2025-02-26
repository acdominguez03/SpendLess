//
//  loginViewModel.swift
//  SpendLess
//
//  Created by Andres Cordón on 8/2/25.
//

import Foundation
import SwiftUI
import SwiftData

@Observable
@MainActor final class LoginViewModel {
    var path: Binding<[Views]>?
    
    var username: String = ""
    var pin: String = ""
    
    var showError: Bool = false
    var errorMesage: String = "Username or PIN is incorrect"
    
    let loginUseCase: LoginUseCaseProtocol
    let updateLastUserConnectionUseCase: UpdateLastUserConnectionUseCase
    
    init() {
        self.loginUseCase = LoginUseCase(repository: UserRepositoryImpl.shared)
        self.updateLastUserConnectionUseCase = UpdateLastUserConnectionUseCase(repository: UserRepositoryImpl.shared)
    }
    
    func loginUser() async {
        let result = await loginUseCase.execute(username: username, pin: Utils.shared.hashValue(value: pin))
         
        switch result {
        case .success(let loginSuccessful):
            if loginSuccessful {
                print("Login successful")
                let updateConnection = await updateLastUserConnectionUseCase.execute(username: username)
                switch updateConnection {
                case .success(let isUpdated):
                    if isUpdated {
                        DispatchQueue.main.async {
                            self.path?.wrappedValue.removeAll()
                            self.path?.wrappedValue.append(Views.DashboardView)
                        }
                    }
                case .failure(let error):
                    showError = true
                    errorMesage = error.localizedDescription
                }
            } else {
                showError = true
                errorMesage = "Username or PIN is incorrect"
            }
        case .failure(let error):
            print(error)
        }
    }
}
