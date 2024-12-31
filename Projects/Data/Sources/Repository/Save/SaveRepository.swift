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
import FirebaseAuth

enum SaveError: Error{
    case noUID
    case failedMakeFolder
    case notMoyaErrorType
    case failedFetchFolder
}

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
    public func makeFolder() -> AnyPublisher<String, Error>{
        guard let uid = Auth.auth().currentUser?.uid else { return Fail(error: SaveError.noUID).eraseToAnyPublisher() }
        let newModel = FolderModelDTO(title: "무제", subfolders: [], URLs: [], uid: uid)
        return service.requestPublisher(.makeFolder(documentId: newModel.id.value, model: newModel))
                .tryMap { response in
                    guard response.statusCode == 200 else{
                        throw SaveError.failedMakeFolder
                    }
                    return newModel.id.value
                }
                .catch { error -> AnyPublisher<String, Error> in
                    guard let error = error as? MoyaError else { return Fail(error: SaveError.notMoyaErrorType).eraseToAnyPublisher() }
                    switch error{
                    case .statusCode(let response):
                        print("Error Status Code: \(response.statusCode)")
                        if let message = String(data: response.data, encoding: .utf8) {
                            print("Error Message: \(message)")
                        }
                    default:
                        print("Unknown Error: \(error.localizedDescription)")
                    }
                    return Fail(error: error).eraseToAnyPublisher()
                }
                .eraseToAnyPublisher()
    }
    
    public func saveFolderIdInUser(folderId: String) -> AnyPublisher<Void, Error> {
        guard let uid = Auth.auth().currentUser?.uid else { return Fail(error: SaveError.noUID).eraseToAnyPublisher() }
        return service.requestPublisher(.saveFolderIdInUser(uid: uid, folderId: folderId))
            .tryMap{ response in
                guard response.statusCode == 200 else {
                    throw SaveError.failedMakeFolder
                }
                return ()
            }
            .catch{ error -> AnyPublisher<Void, Error> in
                guard let error = error as? MoyaError else { 
                    print(error.localizedDescription)
                    return Fail(error: SaveError.notMoyaErrorType).eraseToAnyPublisher()
                }
                switch error{
                case .statusCode(let response):
                    print("Error Status Code: \(response.statusCode)")
                    if let message = String(data: response.data, encoding: .utf8) {
                        print("Error Message: \(message)")
                    }
                default:
                    print("Unknown Error: \(error.localizedDescription)")
                }
                return Fail(error: error).eraseToAnyPublisher()
            }.eraseToAnyPublisher()
    }
    
    public func fetchFolder() -> AnyPublisher<[FolderModel], Error> {
        guard let uid = Auth.auth().currentUser?.uid else { return Fail(error: SaveError.noUID).eraseToAnyPublisher() }
        return service.requestPublisher(.fetchMyFolderIds(uid: uid))
            .tryMap{ response -> [String] in
                let responseData = try JSONDecoder().decode(UserModelDTO.self, from: response.data)
                return responseData.folders.arrayValue["values"]?.compactMap{$0.value} ?? []
            }
            .flatMap { foldersIds -> AnyPublisher<[FolderModel], Error> in
                guard !foldersIds.isEmpty else { return Just([]).setFailureType(to: Error.self).eraseToAnyPublisher() }
                return self.service.requestPublisher(.fetchMyFolder(folderIds: foldersIds))
                    .tryMap{ response -> [FolderModel] in
                        print("ㅎㅇ1")
                        let responseData = try JSONDecoder().decode([QueryResultValue<FolderModelDTO>].self, from: response.data)
                        print("ㅎㅇ2")
//                        return responseData.documents.map{$0.toEntity()}
                        return responseData.map{$0.document!.toEntity()}
                    }.eraseToAnyPublisher()
            }
            .catch { error -> AnyPublisher<[FolderModel], Error> in
                guard let error = error as? MoyaError else { return Fail(error: SaveError.notMoyaErrorType).eraseToAnyPublisher() }
                switch error{
                case .statusCode(let response):
                    print("Error Status Code: \(response.statusCode)")
                    if let message = String(data: response.data, encoding: .utf8) {
                        print("Error Message: \(message)")
                    }
                default:
                    print("Unknown Error: \(error.localizedDescription)")
                }
                return Just([]).setFailureType(to: Error.self).eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
            
        
//        service.requestPublisher(.fetchMyFolder(folderIds: []))
//            .tryMap{ response -> [FolderModel] in
//                let responseData = try JSONDecoder().decode(Documents<[FolderModelDTO]>.self, from: response.data)
//                return responseData.documents.map{$0.toEntity()}
//            }
//            .catch { error -> AnyPublisher<[FolderModel], Error> in
//                guard let error = error as? MoyaError else { return Fail(error: SaveError.notMoyaErrorType).eraseToAnyPublisher() }
//                switch error{
//                case .statusCode(let response):
//                    print("Error Status Code: \(response.statusCode)")
//                    if let message = String(data: response.data, encoding: .utf8) {
//                        print("Error Message: \(message)")
//                    }
//                default:
//                    print("Unknown Error: \(error.localizedDescription)")
//                }
//                return Just([]).setFailureType(to: Error.self).eraseToAnyPublisher()
//            }
//            .eraseToAnyPublisher()
    }
    
    public func saveURLClip(folderId: String, URLClipId: String) -> AnyPublisher<Bool, Never> {
        return service.requestPublisher(.saveURLClip(folderId: folderId, URLClipId: URLClipId))
            .tryMap { response in
                if response.statusCode == 200{
                    print("success saveURLClip")
                    return true
                }else{
                    print("fail saveURLClip", response.statusCode)
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
            .eraseToAnyPublisher()
    }
}
