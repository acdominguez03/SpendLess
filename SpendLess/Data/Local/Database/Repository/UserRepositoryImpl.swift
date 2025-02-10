//
//  UserRepository.swift
//  SpendLess
//
//  Created by Andres Cordón on 7/2/25.
//

import SwiftData
import SwiftUI

final class UserRepositoryImpl: UserRepository {
    
    private let swiftDataService: SwiftDataService
    private let modelContext: ModelContext
    
    @MainActor
    static let shared = UserRepositoryImpl()
    
    @MainActor
    private init() {
        self.swiftDataService = SwiftDataService.shared
        self.modelContext = swiftDataService.modelContext
    }
    
    @MainActor
    func createUser(userModel: EncryptedUserModel) async -> Result<UserModel, any Error> {
        modelContext.insert(userModel)
        do {
            try modelContext.save()
            return .success(userModel.decryptAll() ?? UserModel())
            
        } catch let error as NSError {
            return .failure(error)
        }
    }
    
    @MainActor
    func getUsers() async -> Result<[EncryptedUserModel], any Error> {
        let descriptor = FetchDescriptor<EncryptedUserModel>(predicate: nil)
        
        do {
            let users = try modelContext.fetch(descriptor)
            return .success(users)
        } catch {
            return .failure(error)
        }
    }
    
    @MainActor
    func getUserByUsername(username: String) async -> Result<EncryptedUserModel?, any Error> {
        let descriptor = FetchDescriptor<EncryptedUserModel>(
            predicate: #Predicate{ $0.username == username }
        )
        
        do {
            let user = try modelContext.fetch(descriptor).first
            return .success(user)
        } catch {
            return .failure(error)
        }
    }
    
    @MainActor
    func loginUser(username: String, pin: String) async -> Result<EncryptedUserModel?, any Error> {
        let descriptor = FetchDescriptor<EncryptedUserModel>(
            predicate: #Predicate{ $0.username == username && $0.pin == pin }
        )
        
        do {
            let user = try modelContext.fetch(descriptor).first
            return .success(user)
        } catch {
            return .failure(error)
        }
    }
    
    @MainActor
    func updateLastUserConnection(username: String) async -> Result<Bool, any Error> {
        let result = await getUserByUsername(username: username)
        
        switch result {
        case .success(let user):
            if user != nil {
                user?.lastConnection = Utils.shared.encrypt(text: Utils.shared.dateToString(Date.now)) ?? Data()
                try? modelContext.save()
                return .success(true)
            } else {
                return .success(false)
            }
        case .failure(let error):
            return .failure(error)
        }
    }
}
