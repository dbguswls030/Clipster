//
//  AuthUseCase.swift
//  Domain
//
//  Created by 유현진 on 12/13/24.
//

import Foundation
import AuthenticationServices

final public class AuthUseCase: AuthUseCaseProtocol{
    
    private let repository: AuthRepositoryProtocol
    
    public init(repository: AuthRepositoryProtocol) {
        self.repository = repository
    }
    
    public func signInWithApple() async throws -> AppleCredentialModel{
        try await repository.signInWithApple()
    }

    public func signInWithFirebase(model: AppleCredentialModel) async throws -> String{
        try await repository.signInWithFirebase(model: model)
    }
    
    public func checkIsExistedUser(uid: String) async throws -> Bool {
        try await repository.checkIsExistedUser(uid: uid)
    }
    
    public func createUser(uid: String) async throws{
        try await repository.createUser(uid: uid)
    }
}
