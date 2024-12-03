//
//  SaveUseCase.swift
//  Domain
//
//  Created by 유현진 on 12/2/24.
//

import Foundation
import Combine

final public class SaveUseCase: SaveUseCaseProtocol{
    private let repository:  SaveRepositoryProtocol
    
    public init(repository: SaveRepositoryProtocol) {
        self.repository = repository
    }
    public func fetchMetaData(url: URL) -> AnyPublisher<URLMetaData?, Never> {
        repository.fetchMetaData(url: url)
    }
}
