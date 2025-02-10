//
//  RegistrationUsernameViewModel.swift
//  SpendLess
//
//  Created by Andres Cordón on 4/2/25.
//

import Foundation
import SwiftUICore

@Observable
@MainActor final class UsernameViewModel {
    var path: Binding<[Screen]>?
    var username: String = ""
    
    var showError: Bool = false
    var errorMessage: String = ""
    
    let checkUsernameAlreadyExistUseCase: CheckUsernameAlreadyExistUseCase
    
    init() {
        self.checkUsernameAlreadyExistUseCase = CheckUsernameAlreadyExistUseCase(repository: UserRepositoryImpl.shared)
    }
    
    func checkUsername() async {
        errorMessage = ""
        
        if (username.count < 3) {
            errorMessage = "Username must be at least 3 characters"
            showError = true
        } else if (username.count > 14) {
            errorMessage = "Username must not exceed 14 characters"
            showError = true
        } else {
            let filtered = username.filter { character in
                character.isLetter || character.isNumber
            }
            
            if filtered != username {
                errorMessage = "Only alphanumeric and digits are allowed"
                showError = true
            } else {
                let result = await checkUsernameAlreadyExistUseCase.execute(username: Utils.shared.hashValue(value: username))
                
                switch result {
                case .success(let alreadyExist):
                    if alreadyExist {
                        showError = true
                        errorMessage = "This username already exist"
                    } else {
                        showError = false
                        DispatchQueue.main.async {
                            UserDefaultsManager.shared.username = self.username
                            self.path?.wrappedValue.append(Screen.CreatePinScreen)
                        }
                    }
                case .failure(let error):
                    showError = true
                    errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func reset() {
        username = ""
        showError = false
        errorMessage = ""
    }
}
