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
    public init() {}
    private var cancellable = Set<AnyCancellable>()
    
//    private let service: MoyaProvider<SaveService>
//    public init() {
//        let plugin = NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))
//        service = MoyaProvider<SaveService>(plugins: [plugin])
//    }
    


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
    
    public func makeURLClip(model: URLClipModel) -> AnyPublisher<String?, Never> {
        let newModel = URLClipModelDTO(model: model)
        return service.requestPublisher(.makeURLClip(model: newModel))
            .map{ _ in
                return newModel.id.value
            }
            .catch { error -> AnyPublisher<String?, Never> in
                switch error{
                case .statusCode(let response):
                    print("Error Status Code: \(response.statusCode)")
                    if let message = String(data: response.data, encoding: .utf8) {
                        print("Error Message: \(message)")
                    }
                default:
                    print("Unknown Error: \(error.localizedDescription)")
                }
                return Just(nil).eraseToAnyPublisher()
            }
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
    
    public func saveURLClip(folderId: String, URLClipId: String) -> AnyPublisher<Bool, Never> {
        return service.requestPublisher(.saveURLClip(folderId: folderId, URLClipId: URLClipId))
            .tryMap { response in
                if response.statusCode == 200{
                    print("success")
                    return true
                }else{
                    print(response.statusCode, "fail")
                    print(String(data: response.data, encoding: .utf8))
                    return false
                }
            }
            .catch { error -> AnyPublisher<Bool, Never> in
                guard let error = error as? MoyaError else { return Just(false).eraseToAnyPublisher() }
                switch error{
                case .statusCode(let response):
                    print("Error Status Code: \(response.statusCode)")
                    if let message = String(data: response.data, encoding: .utf8) {
                        print("Error Message: \(message)")
                    }
                default:
                    print("Unknown Error: \(error.localizedDescription)")
                }
                return Just(false).eraseToAnyPublisher()
            }
            .print()
            .eraseToAnyPublisher()
    }
}
