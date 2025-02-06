//
//  UserRepository.swift
//  SpendLess
//
//  Created by Andres Cordón on 7/2/25.
//

protocol UserRepository {
    func createUser(userModel: EncryptedUserModel) async -> Result<UserModel, Error>
}
