//
//  UserRepository.swift
//  SpendLess
//
//  Created by Andres Cordón on 7/2/25.
//

import SwiftData

final class UserRepositoryImpl: UserRepository {
    
    private let modelContainer: ModelContainer
    private let modelContext: ModelContext
    
    @MainActor
    private init() {
        self.modelContainer = try! ModelContainer(for: EncryptedUserModel.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        self.modelContext = modelContainer.mainContext
    }
    
    @MainActor
    static func shared() -> UserRepositoryImpl {
        return UserRepositoryImpl()
    }
    
    func createUser(userModel: EncryptedUserModel) async -> Result<UserModel, any Error> {
        modelContext.insert(userModel)
        do {
            try modelContext.save()
            return .success(userModel.decryptAll()!)
        } catch {
            return .failure(error)
        }
    }
    
}
