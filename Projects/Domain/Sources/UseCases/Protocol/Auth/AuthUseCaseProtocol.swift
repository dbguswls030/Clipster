//
//  AuthUseCaseProtocol.swift
//  Domain
//
//  Created by 유현진 on 12/13/24.
//

import Foundation
import AuthenticationServices

public protocol AuthUseCaseProtocol{
    func signInWithApple() async throws -> AppleCredentialModel
    func signInWithFirebase(model: AppleCredentialModel) async throws -> String
    func checkIsExistedUser(uid: String) async throws -> Bool
    func createUser(uid: String) async throws
}
