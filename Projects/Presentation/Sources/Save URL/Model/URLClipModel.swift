//
//  URLClipModel.swift
//  Presentation
//
//  Created by 유현진 on 11/30/24.
//

import Foundation
import Domain
struct URLClipModel: Identifiable{
    let id: UUID
    let folderId: UUID
    let URL: URL
    let description: String
    let metaData: URLMetaData
    
    init(id: UUID = UUID(), folderId: UUID, URL: URL, description: String, metaData: URLMetaData) {
        self.id = id
        self.folderId = folderId
        self.URL = URL
        self.description = description
        self.metaData = metaData
    }
}
