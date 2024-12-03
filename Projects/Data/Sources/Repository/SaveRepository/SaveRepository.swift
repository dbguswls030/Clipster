//
//  SaveRepository.swift
//  Data
//
//  Created by 유현진 on 12/3/24.
//

import Foundation
import Combine
import Domain
import Moya
import CombineMoya

final public class SaveRepository: SaveRepositoryProtocol{
    private let service = MoyaProvider<SaveService>()
    
    private var cancellable = Set<AnyCancellable>()
    
    public init() {}
    
    public func fetchMetaData(url: URL) -> AnyPublisher<URLMetaData?, Never> {
        return service.requestPublisher(.fetchURLMetadata(url: url))
            .tryMap{ response in
                let html = String(data: response.data, encoding: .utf8) ?? ""
                return try? URLMetaDataResponseDTO.parseHTML(html)
            }
            .replaceError(with: nil)
            .eraseToAnyPublisher()
    }
}
