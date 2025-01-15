//
//  ClipUseCase.swift
//  Domain
//
//  Created by 유현진 on 12/2/24.
//

import Foundation

final public class ClipUseCase: ClipUseCaseProtocol{
    private let repository:  ClipRepositoryProtocol
    
    public init(repository: ClipRepositoryProtocol) {
        self.repository = repository
    }
}
extension ClipUseCase{
    // MARK: URL
    public func fetchMetaData(url: URL) async throws -> URLMetaData?{
        try await repository.fetchMetaData(url: url)
    }
    
    public func makeURLClip(model: URLClipModel) async throws -> String{
        try await repository.makeURLClip(model: model)
    }
    
    public func fetchURLs(urls: [URL]) async throws -> [URLClipModel] {
        try await repository.fetchURLs(urls: urls)
    }
}
extension ClipUseCase{
    // MARK: Folder
    public func makeFolder() async throws{
        try await repository.makeFolder()
    }
    
    public func makeFolder(newFolderName: String) async throws{
        try await repository.makeFolder(newFolderName: newFolderName)
    }
    
    public func fetchFolder() async throws -> [FolderModel]{
        try await repository.fetchFolder()
    }
    
    public func saveURLClip(folderId: String, URLClipId: String) async throws{
        try await repository.saveURLClip(folderId: folderId, URLClipId: URLClipId)
    }
}
