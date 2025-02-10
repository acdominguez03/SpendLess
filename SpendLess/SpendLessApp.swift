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
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            EncryptedUserModel.self,
            EncryptedIncomeModel.self,
            EncryptedExpenseModel.self
        ])

        do {
            return try ModelContainer(for: schema)
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            UsernameView()
        }
        .modelContainer(sharedModelContainer)
    }
}
