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
    var path: Binding<[Screen]>?
    
    var username: String = ""
    var pin: String = ""
    
    var showError: Bool = false
    var errorMesage: String = "Username or PIN is incorrect"
    
    let loginUseCase: LoginUseCaseProtocol
    let updateLastUserConnectionUseCase: UpdateLastUserConnectionUseCase
    
    init(loginUseCase: LoginUseCase, updateLastUserConnectionUseCase: UpdateLastUserConnectionUseCase) {
        self.loginUseCase = loginUseCase
        self.updateLastUserConnectionUseCase = updateLastUserConnectionUseCase
    }
    
    func loginUser() async {
        let hashedUsername = Utils.shared.hashValue(value: username)
        
        let result = await loginUseCase.execute(username: hashedUsername, pin: Utils.shared.hashValue(value: pin))
         
        switch result {
        case .success(let loginSuccessful):
            if loginSuccessful {
                print("Login successful")
                let updateConnection = await updateLastUserConnectionUseCase.execute(username: hashedUsername)
                switch updateConnection {
                case .success(let isUpdated):
                    if isUpdated {
                        DispatchQueue.main.async {
                            self.path?.wrappedValue.removeAll()
                            self.path?.wrappedValue.append(Screen.DashboardScreen)
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
