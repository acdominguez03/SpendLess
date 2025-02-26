//
//  UserRepository.swift
//  SpendLess
//
//  Created by Andres Cordón on 7/2/25.
//

protocol UserRepository {
    func createUser(userModel: UserModel) async -> Result<UserModel, Error>
    func getUsers() async -> Result<[UserModel], Error>
    func getLoggedUser() async -> Result<UserModel?, Error>
    func loginUser(username: String, pin: String) async -> Result<UserModel?, Error>
    func updateLastUserConnection(username: String) async -> Result<Bool, Error>
}
