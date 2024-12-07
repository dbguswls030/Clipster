//
//  FolderModel.swift
//  Domain
//
//  Created by 유현진 on 12/5/24.
//

import Foundation

public struct FolderModel: Identifiable{
    public var id: String
    public var title: String
    public var subfolders: [FolderModel]
    public var URLs: [URLClipModel] = []
    
    public init(id: String = UUID().uuidString, title: String, subfolders: [FolderModel]) {
        self.id = id
        self.title = title
        self.subfolders = subfolders
    }
    
    static public var sampleData1: FolderModel{
        return FolderModel(title: "경제", subfolders: [FolderModel(title: "IT", subfolders: [FolderModel(title: "문학", subfolders: [])]),
                                                  FolderModel(title: "옷", subfolders: []),
                                                  FolderModel(title: "유튜브", subfolders: [])
                                                 ])
    }
    static public var sampleData2: FolderModel{
        return FolderModel(title: "주식", subfolders: [FolderModel(title: "아시아", subfolders: [FolderModel(title: "한국", subfolders: [])]),
                                                  FolderModel(title: "채권", subfolders: []),
                                                  FolderModel(title: "계좌", subfolders: [])
                                                 ])
    }
}
