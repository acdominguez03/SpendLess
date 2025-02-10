//
//  UserRepository.swift
//  SpendLess
//
//  Created by Andres Cordón on 7/2/25.
//

protocol UserRepository {
    func createUser(userModel: EncryptedUserModel) async -> Result<UserModel, Error>
    func getUsers() async -> Result<[EncryptedUserModel], Error>
    func getUserByUsername(username: String) async -> Result<EncryptedUserModel?, Error>
    func loginUser(username: String, pin: String) async -> Result<EncryptedUserModel?, Error>
    func updateLastUserConnection(username: String) async -> Result<Bool, Error>
}
