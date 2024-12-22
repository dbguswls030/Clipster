//
//  RootRepositoryProtocol.swift
//  Domain
//
//  Created by 유현진 on 12/18/24.
//

import Foundation
import Combine
public protocol RootRepositoryProtocol {
    func authStateListener() -> AnyPublisher<Bool, Never>
    func fetchCurrentUser() -> AnyPublisher<Bool, Never>
}
