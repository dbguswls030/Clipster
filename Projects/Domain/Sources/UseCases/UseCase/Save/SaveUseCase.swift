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
    public func fetchMetaData(url: URL) async throws -> URLMetaData?{
        try await repository.fetchMetaData(url: url)
    }
    
    public func makeURLClip(model: URLClipModel) async throws -> String{
        try await repository.makeURLClip(model: model)
    }
}
extension SaveUseCase{
    // MARK: Folder
    public func makeFolder() async throws{
        try await repository.makeFolder()
    }
    
    public func fetchFolder() async throws -> [FolderModel]{
        try await repository.fetchFolder()
    }
    
    public func saveURLClip(folderId: String, URLClipId: String) async throws{
        try await repository.saveURLClip(folderId: folderId, URLClipId: URLClipId)
    }
}
