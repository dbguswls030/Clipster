//
//  SaveRepositoryProtocol.swift
//  Domain
//
//  Created by 유현진 on 12/3/24.
//

import Foundation
import Combine

public protocol SaveRepositoryProtocol{
    // MARK: URL
    func fetchMetaData(url: URL) -> AnyPublisher<URLMetaData?, Never>
    func makeURLClip(model: URLClipModel) -> AnyPublisher<String?, Never>
    
    // MARK: Folder
    func makeFolder() -> AnyPublisher<Void, Never>
    func fetchFolder() -> AnyPublisher<[FolderModel], Never>
    func saveURLClip(folderId: String, URLClipId: String) -> AnyPublisher<Bool, Never>
}
