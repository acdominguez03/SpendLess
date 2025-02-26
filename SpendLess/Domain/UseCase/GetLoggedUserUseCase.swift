//
//  GetUserByUsernameUseCase.swift
//  SpendLess
//
//  Created by Andres Cordón on 14/2/25.
//

protocol GetLoggedUserUseCaseProtocol {
    func execute() async -> Result<UserModel?, Error>
}

class GetLoggedUserUseCase: GetLoggedUserUseCaseProtocol {
    
    let repository: UserRepository
    
    init(repository: UserRepository) {
        self.repository = repository
    }
    
    func execute() async -> Result<UserModel?, Error> {
        let result = await repository.getLoggedUser()

        switch result {
        case .success(let user):
            return .success(user)
        case .failure(let error):
            return .failure(error)
        }
    }
}
