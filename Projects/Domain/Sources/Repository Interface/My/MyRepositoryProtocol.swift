//
//  MyRepositoryProtocol.swift
//  Domain
//
//  Created by 유현진 on 12/17/24.
//

import Foundation

public protocol MyRepositoryProtocol{
    func logout() async throws
    func signout() async throws
}
