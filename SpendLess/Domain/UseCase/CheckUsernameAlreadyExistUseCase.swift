//
//  CheckUsernameAlreadyExistUseCase.swift
//  SpendLess
//
//  Created by Andres Cordón on 10/2/25.
//


protocol CheckUsernameAlreadyExistUseCaseProtocol {
    func execute(username: String) async -> Result<Bool, Error>
}

class CheckUsernameAlreadyExistUseCase: CheckUsernameAlreadyExistUseCaseProtocol {
    
    let repository: UserRepository
    
    init(repository: UserRepository) {
        self.repository = repository
    }
    
    func execute(username: String) async -> Result<Bool, any Error> {
        let result = await repository.getUserByUsername(username: username)
        
        switch result {
        case .success(let user):
            if user != nil {
                return .success(true)
            } else {
                return .success(false)
            }
        case .failure(let error):
            return .failure(error)
        }
    }
}

