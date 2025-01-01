//
//  AuthRepositoryProtocol.swift
//  Domain
//
//  Created by 유현진 on 12/13/24.
//

import Foundation
import Combine
import AuthenticationServices

public protocol AuthRepositoryProtocol{
    func signInWithApple() -> AnyPublisher<AppleCredentialModel, Error>
    func signInWithFirebase(model: AppleCredentialModel) async throws -> String
    func checkIsExistedUser(uid: String) async throws -> Bool
    func createUser(uid: String) async throws
}
