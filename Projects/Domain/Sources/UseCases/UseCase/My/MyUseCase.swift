//
//  MyUseCase.swift
//  Domain
//
//  Created by 유현진 on 12/17/24.
//

import Foundation
import Combine

final public class MyUseCase: MyUseCaseProtocol {
    let repository: MyRepositoryProtocol
    
    public init(repository: MyRepositoryProtocol) {
        self.repository = repository
    }
    
    public func logout() async throws {
        try await repository.logout()
    }
    
    public func signout() async throws{
        try await repository.signout()
    }
}
