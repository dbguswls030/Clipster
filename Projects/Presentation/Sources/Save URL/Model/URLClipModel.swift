//
//  URLClipModel.swift
//  Presentation
//
//  Created by 유현진 on 11/30/24.
//

import Foundation

struct URLClipModel: Identifiable{
    let id: UUID
    let folderId: UUID
    let URL: URL
    let description: String
    let metaData: URLMetaData
}
