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
    public func signOut() -> AnyPublisher<Void, Error>{
        repository.signOut()
    }
}
