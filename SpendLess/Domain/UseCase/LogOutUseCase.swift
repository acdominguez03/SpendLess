//
//  LogOutUseCase.swift
//  SpendLess
//
//  Created by Andres Cordón on 27/2/25.
//

protocol LogOutUseCaseProtocol {
    func execute() async -> Result<Bool, Error>
}

class LogOutUseCase: LogOutUseCaseProtocol {
    let repository: UserRepository
    
    init(repository: UserRepository) {
        self.repository = repository
    }
    
    func execute() async -> Result<Bool, any Error> {
        let result = await repository.logOut()
        
        switch result {
        case .success(let isLogOut):
            return .success(isLogOut)
        case .failure(let error):
            return .failure(error)
        }
    }
}
