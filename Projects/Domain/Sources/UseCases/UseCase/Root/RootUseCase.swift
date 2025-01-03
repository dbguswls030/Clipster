//
//  RootUseCase.swift
//  Domain
//
//  Created by 유현진 on 12/18/24.
//

import Foundation

final public class RootUseCase: RootUseCaseProtocol{
    let repository: RootRepositoryProtocol
    
    public init(repository: RootRepositoryProtocol) {
        self.repository = repository
    }
    
    public func fetchCurrentUser() async -> Bool {
        await repository.fetchCurrentUser()
    }
}
