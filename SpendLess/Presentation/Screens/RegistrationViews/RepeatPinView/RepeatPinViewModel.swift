//
//  RepeatPinViewModel.swift
//  SpendLess
//
//  Created by Andres Cordón on 5/2/25.
//

import Foundation
import SwiftUI

@Observable
@MainActor final class RepeatPinViewModel {
    var path: Binding<[Screen]>?
    
    var pin: String = ""
    var showError: Bool = false
    
    func updatePin(newValue: String) {
        showError = false
        pin += newValue
        
        if pin.count == 5 {
            if pin == UserDefaultsManager.shared.pin {
                DispatchQueue.main.async {
                    self.path?.wrappedValue.append(Screen.OnboardingPreferencesScreen)
                }
            } else {
                showError = true
                pin = ""
            }
        }
    }
    
    func backButtonPressed() {
        DispatchQueue.main.async {
            self.path?.wrappedValue.removeLast()
            UserDefaultsManager.shared.resetPin()
        }
    }
    
    func eliminateLastPinDigit() {
        pin.removeLast()
    }
}
