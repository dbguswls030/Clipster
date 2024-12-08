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
    
//    private let service: MoyaProvider<SaveService>
//    
//    public init() {
//        let plugin = NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))
//        service = MoyaProvider<SaveService>(plugins: [plugin])
//    }
    
    public init() {}

}
extension SaveRepository{
    // MARK: URL
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
extension SaveRepository{
    // MARK: Folder
    public func makeFolder() -> AnyPublisher<Void, Never>{
        let newModel = FolderModelDTO(title: "무제", subfolders: [], URLs: [])
        return service.requestPublisher(.makeFolder(documentId: newModel.id.value, model: newModel))
                .map { response in
                    
                }
                .catch { error in
                    switch error{
                    case .statusCode(let response):
                        print("Error Status Code: \(response.statusCode)")
                        if let message = String(data: response.data, encoding: .utf8) {
                            print("Error Message: \(message)")
                        }
                    default:
                        print("Unknown Error: \(error.localizedDescription)")
                    }
                    return Just(()).eraseToAnyPublisher()
                }
                .eraseToAnyPublisher()
    }
    
    public func fetchFolder() -> AnyPublisher<[FolderModel], Never> {
        return service.requestPublisher(.fetchFolder)
            .tryMap{ response -> [FolderModel] in
                let responseData = try JSONDecoder().decode(Documents<[FolderModelDTO]>.self, from: response.data)
                return responseData.documents.map{$0.toEntity()}
            }
            .catch { error -> AnyPublisher<[FolderModel], Never> in
                guard let error = error as? MoyaError else { return Just([]).eraseToAnyPublisher() }
                switch error{
                case .statusCode(let response):
                    print("Error Status Code: \(response.statusCode)")
                    if let message = String(data: response.data, encoding: .utf8) {
                        print("Error Message: \(message)")
                    }
                default:
                    print("Unknown Error: \(error.localizedDescription)")
                }
                return Just([]).eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}
