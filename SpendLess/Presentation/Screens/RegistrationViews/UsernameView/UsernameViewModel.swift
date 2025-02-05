//
//  RegistrationUsernameViewModel.swift
//  SpendLess
//
//  Created by Andres Cordón on 4/2/25.
//

import Foundation

@Observable
@MainActor final class UsernameViewModel {
    var username: String = ""
    var navigateToPinScreen: Bool = false
    
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
                    UserDefaultsManager.shared.username = username
                    navigateToPinScreen = true
                }
            }
        }
    }
    
}
