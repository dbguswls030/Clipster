//
//  RootUseCase.swift
//  Domain
//
//  Created by 유현진 on 12/18/24.
//

import Foundation
import Combine

final public class RootUseCase: RootUseCaseProtocol{
    let repository: RootRepositoryProtocol
    
    public init(repository: RootRepositoryProtocol) {
        self.repository = repository
    }
    
    public func authStateListener() -> AnyPublisher<Bool, Never> {
        repository.authStateListener()
    }

    public func fetchCurrentUser() -> AnyPublisher<Bool, Never> {
        repository.fetchCurrentUser()
    }
}
