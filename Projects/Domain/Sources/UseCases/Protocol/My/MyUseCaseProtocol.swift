//
//  MyUseCaseProtocol.swift
//  Domain
//
//  Created by 유현진 on 12/17/24.
//

import Foundation
import Combine
public protocol MyUseCaseProtocol{
    func logout() async throws
    func signout() async throws
}
