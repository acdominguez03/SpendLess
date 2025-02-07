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
    
    func checkUsername() {
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
                if (username.contains(" ")) {
                    errorMessage = "No space characters are allowed"
                    showError = true
                } else {
                    showError = false
                    DispatchQueue.main.async {
                        UserDefaultsManager.shared.username = self.username
                        self.path?.wrappedValue.append(Screen.CreatePinScreen)
                    }
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
