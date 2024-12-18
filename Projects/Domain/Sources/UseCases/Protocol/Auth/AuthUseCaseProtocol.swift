//
//  AuthUseCaseProtocol.swift
//  Domain
//
//  Created by 유현진 on 12/13/24.
//

import Foundation
import Combine
import AuthenticationServices

public protocol AuthUseCaseProtocol{
    func signInWithApple() -> AnyPublisher<String, Error>
}
