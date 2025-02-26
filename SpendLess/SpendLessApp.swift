//
//  SpendLessApp.swift
//  SpendLess
//
//  Created by Andres Cordón on 3/2/25.
//

import SwiftUI
import SwiftData

@main
struct SpendLessApp: App {
    init() {
        UIView.appearance().overrideUserInterfaceStyle = .light
    }
    
    var body: some Scene {
        WindowGroup {
            SplashScreenView()
        }
    }
}
