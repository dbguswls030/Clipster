//
//  AuthUseCase.swift
//  Domain
//
//  Created by 유현진 on 12/13/24.
//

import Foundation
import Combine
import AuthenticationServices

final public class AuthUseCase: AuthUseCaseProtocol{
    private let repository: AuthRepositoryProtocol
    
    public init(repository: AuthRepositoryProtocol) {
        self.repository = repository
    }
    
    public func signInWithApple() -> AnyPublisher<AppleCredentialModel, Error>{
        repository.signInWithApple()
    }
    
    public func signInWithFirebase(model: AppleCredentialModel) -> AnyPublisher<String, Error> {
        repository.signInWithFirebase(model: model)
    }
    
    public func checkIsExistedUser(uid: String) -> AnyPublisher<Bool, Error> {
        repository.checkIsExistedUser(uid: uid)
    }
    
    public func createUser(uid: String) -> AnyPublisher<Void, Error>{
        repository.createUser(uid: uid)
    }
}
