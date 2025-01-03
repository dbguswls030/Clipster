//
//  URLClipModel.swift
//  Domain
//
//  Created by 유현진 on 12/5/24.
//

import Foundation

public struct URLClipModel: Identifiable{
    public let id: String
    public let uid: String
    public let folderId: String
    public let URL: URL
    public let description: String
    public let metaData: URLMetaData
    public let createAt: Date
    
    public init(id: String = UUID().uuidString, uid: String, folderId: String, URL: URL, description: String, metaData: URLMetaData, createAt: Date = Date()) {
        self.id = id
        self.uid = uid
        self.folderId = folderId
        self.URL = URL
        self.description = description
        self.metaData = metaData
        self.createAt = createAt
    }
}
