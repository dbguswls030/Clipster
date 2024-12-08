//
//  SaveRepositoryProtocol.swift
//  Domain
//
//  Created by 유현진 on 12/3/24.
//

import Foundation
import Combine

public protocol SaveRepositoryProtocol{
    func fetchMetaData(url: URL) -> AnyPublisher<URLMetaData?, Never>
    func makeFolder() -> AnyPublisher<Void, Never>
    func fetchFolder() -> AnyPublisher<[FolderModel], Never>
}
