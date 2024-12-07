//
//  SaveUseCaseProtocol.swift
//  Domain
//
//  Created by 유현진 on 12/2/24.
//

import Foundation
import Combine

public protocol SaveUseCaseProtocol{
    func fetchMetaData(url: URL) -> AnyPublisher<URLMetaData?, Never>
    func makeFolder() -> AnyPublisher<Void, Never>
}
