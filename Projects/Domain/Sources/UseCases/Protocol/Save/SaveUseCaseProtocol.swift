//
//  SaveUseCaseProtocol.swift
//  Domain
//
//  Created by 유현진 on 12/2/24.
//

import Foundation
import Combine

public protocol SaveUseCaseProtocol{
    // MARK: URL
    func fetchMetaData(url: URL) async throws -> URLMetaData?
    func makeURLClip(model: URLClipModel) async throws -> String
    
    // MARK: Folder
    func makeFolder() async throws
    func fetchFolder() async throws -> [FolderModel]
    func saveURLClip(folderId: String, URLClipId: String) async throws
}

