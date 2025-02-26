//
//  SettingsViewModel.swift
//  SpendLess
//
//  Created by Andres Cordón on 27/2/25.
//

import Foundation
import SwiftUI

@Observable
@MainActor final class SettingsViewModel {
    
    var path: Binding<[Views]>?
    
    let logOutUseCase: LogOutUseCase
    
    init() {
        self.logOutUseCase = LogOutUseCase(repository: UserRepositoryImpl.shared)
    }
    
    func logOut() async {
        let result = await logOutUseCase.execute()
        
        switch result {
        case .success(let isLoggedOut):
            if isLoggedOut {
                DispatchQueue.main.async {
                    self.path?.wrappedValue.removeAll()
                    self.path?.wrappedValue.append(Views.UsernameView)
                }
            } else {
                print("Error al cerrar sesión")
            }
        case .failure(let error):
            print(error)
        }
    }
}
