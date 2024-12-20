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
    func signInWithFirebase(model: AppleCredentialModel) -> AnyPublisher<String, Error>
    func checkIsExistedUser(uid: String) -> AnyPublisher<Bool, Error>
    func createUser(uid: String) -> AnyPublisher<Void, Error>
}
