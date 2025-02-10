//
//  GetUserByUsernameUseCase.swift
//  SpendLess
//
//  Created by Andres Cordón on 14/2/25.
//

protocol GetUserByUsernameUseCaseProtocol {
    func execute(username: String) async -> Result<UserModel, Error>
}

class GetUserByUsernameUseCase: GetUserByUsernameUseCaseProtocol {
    
    let repository: UserRepository
    
    init(repository: UserRepository) {
        self.repository = repository
    }
    
    func execute(username: String) async -> Result<UserModel, Error> {
        let result = await repository.getUserByUsername(username: username)

        switch result {
        case .success(let user):
            return .success(user?.decryptAll() ?? UserModel())
        case .failure(let error):
            return .failure(error)
        }
    }
}
