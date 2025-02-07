//
//  CreatePinViewModel.swift
//  SpendLess
//
//  Created by Andres Cordón on 5/2/25.
//

import Foundation
import SwiftUI

@Observable
@MainActor final class CreatePinViewModel {
    var pin: String = ""
    
    var path: Binding<[Screen]>?
    
    func updatePin(newValue: String) {
        
        pin += newValue
        if pin.count == 5 {
            UserDefaultsManager.shared.pin = pin
            DispatchQueue.main.async {
                self.path?.wrappedValue.append(Screen.RepeatPinScreen)
            }
        }
    }
    
    func eliminateLastPinDigit() {
        pin.removeLast()
    }
    
    func backButtonPressed() {
        DispatchQueue.main.async {
            self.path?.wrappedValue.removeLast()
        }
    }
    
    func reset() {
        pin = ""
    }
}
