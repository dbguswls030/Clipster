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
    
//   public init() {
//       let plugin = NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))
//       service = MoyaProvider<SaveService>(plugins: [plugin])
//   }
    
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
    
    public func makeFolder() -> AnyPublisher<Void, Never>{
        return service.requestPublisher(.makeFolder(FolderModelDTO(title: "무제", subfolders: ["ㅁㄴㅇ"], URLs: ["ㅁㄴㅇ"])))
                .map { response in
                    
                }
                .catch { error in
                    // 오류가 발생하면 출력
                    print("Error: \(error)")
                    return Just(()).eraseToAnyPublisher() // 오류 처리 후 기본값 반환
                }
                .replaceError(with: ())
                .print()
                .eraseToAnyPublisher()
    }
}
