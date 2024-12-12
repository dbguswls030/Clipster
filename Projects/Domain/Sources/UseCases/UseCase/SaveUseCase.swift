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
}
extension SaveUseCase{
    // MARK: URL
    public func fetchMetaData(url: URL) -> AnyPublisher<URLMetaData?, Never> {
        repository.fetchMetaData(url: url)
    }
    
    public func makeURLClip(model: URLClipModel) -> AnyPublisher<String?, Never> {
        repository.makeURLClip(model: model)
    }
}
extension SaveUseCase{
    // MARK: Folder
    public func makeFolder() -> AnyPublisher<Bool, Never>{
        repository.makeFolder()
    }
    
    public func fetchFolder() -> AnyPublisher<[FolderModel], Never> {
        repository.fetchFolder()
    }
    public func saveURLClip(folderId: String, URLClipId: String) -> AnyPublisher<Bool, Never>{
        repository.saveURLClip(folderId: folderId, URLClipId: URLClipId)
    }
}
