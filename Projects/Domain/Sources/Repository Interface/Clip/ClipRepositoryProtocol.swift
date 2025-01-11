//
//  ClipRepositoryProtocol.swift
//  Domain
//
//  Created by 유현진 on 12/3/24.
//

import Foundation

public protocol ClipRepositoryProtocol{
    // MARK: URL
    func fetchMetaData(url: URL) async throws -> URLMetaData?
    func makeURLClip(model: URLClipModel) async throws -> String
    func fetchURLs(urls: [URL]) async throws -> [URLClipModel]
    
    // MARK: Folder
    func makeFolder() async throws
    func fetchFolder() async throws -> [FolderModel]
    func saveURLClip(folderId: String, URLClipId: String) async throws
}
