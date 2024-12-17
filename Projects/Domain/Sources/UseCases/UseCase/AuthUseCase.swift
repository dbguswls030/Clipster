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
    
    public func authStateListener() -> AnyPublisher<Bool, Error> {
        repository.authStateListener()
    }
    
    public func signInWithApple() -> Future<String, Error>{
        repository.signInWithApple()
    }
    public func testSignInWithApple() -> AnyPublisher<String, Error>{
        repository.testSignInWithApple()
    }   
}
