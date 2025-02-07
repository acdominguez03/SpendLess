//
//  CreateUserUsecase.swift
//  SpendLess
//
//  Created by Andres Cordón on 7/2/25.
//

protocol CreateUserUseCaseProtocol {
    func execute(userModel: EncryptedUserModel) async -> Result<UserModel, Error>
}

class CreateUserUseCase: CreateUserUseCaseProtocol {
    
    let repository: UserRepository
    
    init(repository: UserRepository) {
        self.repository = repository
    }
    
    func execute(userModel: EncryptedUserModel) async -> Result<UserModel, Error> {
        let result = await repository.createUser(userModel: userModel)

        switch result {
        case .success(let user):
            return .success(user)
        case .failure(let error):
            return .failure(error)
        }
    }
}
