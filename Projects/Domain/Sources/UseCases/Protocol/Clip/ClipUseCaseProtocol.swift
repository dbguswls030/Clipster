//
//  ClipUseCaseProtocol.swift
//  Domain
//
//  Created by 유현진 on 12/2/24.
//

import Foundation

public protocol ClipUseCaseProtocol{
    // MARK: URL
    func fetchMetaData(url: URL) async throws -> URLMetaData?
    func makeURLClip(model: URLClipModel) async throws -> String
    func fetchURLs(urls: [String]) async throws -> [URLClipModel]
    
    // MARK: Folder
    func makeFolder(newFolderName: String) async throws
    func fetchFolders() async throws -> [FolderModel]
    func fetchFolder(folderId: String) async throws -> FolderModel
    func removeFolder(folder: FolderModel) async throws
    func editFolderTitle(folderId: String, editedTitle: String) async throws
    
    func saveURLClip(folderId: String, URLClipId: String) async throws
    
}

