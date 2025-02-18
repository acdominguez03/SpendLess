//
//  SwiftDataService.swift
//  SpendLess
//
//  Created by Andres Cordón on 12/2/25.
//

import SwiftData
import Foundation

class SwiftDataService {
    let modelContainer : ModelContainer
    let modelContext: ModelContext
    
    private var isPreviewEnvironment: Bool
    
    @MainActor
    static let shared = SwiftDataService()
    
    @MainActor
    private init() {
        isPreviewEnvironment = ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
        
        if isPreviewEnvironment {
            self.modelContainer = try! ModelContainer(for: EncryptedUserModel.self, EncryptedTransactionModel.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        } else {
            self.modelContainer = try! ModelContainer(for: EncryptedUserModel.self, EncryptedTransactionModel.self, configurations: ModelConfiguration(isStoredInMemoryOnly: false))
        }
        self.modelContext = modelContainer.mainContext
    }
}
