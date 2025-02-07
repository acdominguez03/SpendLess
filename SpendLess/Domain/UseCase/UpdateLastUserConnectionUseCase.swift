//
//  UpdateUserLastConnection.swift
//  SpendLess
//
//  Created by Andres Cordón on 10/2/25.
//

protocol UpdateLastUserConnectionUseCaseProtocol {
    func execute(username: String) async -> Result<Bool, Error>
}

class UpdateLastUserConnectionUseCase: UpdateLastUserConnectionUseCaseProtocol {
    let repository: UserRepository
    
    init(repository: UserRepository) {
        self.repository = repository
    }
    
    func execute(username: String) async -> Result<Bool, any Error> {
        let result = await repository.updateLastUserConnection(username: username)
        
        switch result {
        case .success(let user):
            return .success(user)
        case .failure(let error):
            return .failure(error)
        }
    }
}
