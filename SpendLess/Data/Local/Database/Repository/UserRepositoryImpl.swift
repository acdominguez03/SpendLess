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
    func createUser(userModel: UserModel) async -> Result<UserModel, any Error> {
        userModel.isLogged = true
        modelContext.insert(userModel)
        do {
            try modelContext.save()
            return .success(userModel)
        } catch let error as NSError {
            return .failure(error)
        }
    }
    
    @MainActor
    func getUsers() async -> Result<[UserModel], any Error> {
        let descriptor = FetchDescriptor<UserModel>(predicate: nil)
        
        do {
            let users = try modelContext.fetch(descriptor)
            return .success(users)
        } catch {
            return .failure(error)
        }
    }
    
    @MainActor
    func getLoggedUser() async -> Result<UserModel?, any Error> {
        let descriptor = FetchDescriptor<UserModel>(
            predicate: #Predicate{ $0.isLogged == true }
        )
        
        do {
            let user = try modelContext.fetch(descriptor).first
            return .success(user)
        } catch {
            return .failure(error)
        }
    }
    
    @MainActor
    func loginUser(username: String, pin: String) async -> Result<UserModel?, any Error> {
        let descriptor = FetchDescriptor<UserModel>(
            predicate: #Predicate{ $0.username == username && $0.pin == pin }
        )
        
        do {
            let user = try modelContext.fetch(descriptor).first
            user?.isLogged = true
            try? modelContext.save()
            return .success(user)
        } catch {
            return .failure(error)
        }
    }
    
    @MainActor
    func updateLastUserConnection(username: String) async -> Result<Bool, any Error> {
        let result = await getLoggedUser()
        
        switch result {
        case .success(let user):
            if user != nil {
                user?.lastConnection = Date.now
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
