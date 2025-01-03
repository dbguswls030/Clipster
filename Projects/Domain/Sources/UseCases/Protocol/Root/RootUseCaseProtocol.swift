//
//  RootUseCaseProtocol.swift
//  Domain
//
//  Created by 유현진 on 12/18/24.
//

import Foundation

public protocol RootUseCaseProtocol {
    func fetchCurrentUser() async -> Bool
}
