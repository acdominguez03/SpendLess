//
//  LoginUseCase.swift
//  SpendLess
//
//  Created by Andres Cordón on 10/2/25.
//

protocol LoginUseCaseProtocol {
    func execute(username: String, pin: String) async -> Result<Bool, Error>
}

class LoginUseCase: LoginUseCaseProtocol {
    let repository: UserRepository
    
    init(repository: UserRepository) {
        self.repository = repository
    }
    
    func execute(username: String, pin: String) async -> Result<Bool, any Error> {
        let result = await repository.loginUser(username: username, pin: pin)
        
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
