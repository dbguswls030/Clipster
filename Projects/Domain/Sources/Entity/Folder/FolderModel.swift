//
//  FolderModel.swift
//  Domain
//
//  Created by 유현진 on 12/5/24.
//

import Foundation

public struct FolderModel: Identifiable{
    public var uid: String
    public var id: String
    public var title: String
    public var subfolders: [FolderModel]
    public var URLs: [URLClipModel] = []
    
    public init(id: String = UUID().uuidString, title: String, subfolders: [FolderModel] = [], uid: String) {
        self.id = id
        self.title = title
        self.subfolders = subfolders
        self.uid = uid
    }
}
