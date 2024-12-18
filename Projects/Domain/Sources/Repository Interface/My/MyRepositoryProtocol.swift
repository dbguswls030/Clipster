//
//  MyRepositoryProtocol.swift
//  Domain
//
//  Created by 유현진 on 12/17/24.
//

import Foundation
import Combine

public protocol MyRepositoryProtocol{
    func signOut() -> AnyPublisher<Void, Error>
}
