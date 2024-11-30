//
//  FolderModel.swift
//  Presentation
//
//  Created by 유현진 on 11/28/24.
//

import Foundation

struct FolderModel: Identifiable{
    var id: UUID
    var title: String
    var subfolders: [FolderModel]?
    var URLs: [URLClipModel] = []
    
    init(id: UUID = UUID(), title: String, subfolders: [FolderModel]) {
        self.id = id
        self.title = title
        self.subfolders = subfolders
    }
    
    static var sampleData1: FolderModel{
        return FolderModel(title: "경제", subfolders: [FolderModel(title: "IT", subfolders: [FolderModel(title: "문학", subfolders: [])]),
                                                  FolderModel(title: "옷", subfolders: []),
                                                  FolderModel(title: "유튜브", subfolders: [])
                                                 ])
    }
    static var sampleData2: FolderModel{
        return FolderModel(title: "주식", subfolders: [FolderModel(title: "아시아", subfolders: [FolderModel(title: "한국", subfolders: [])]),
                                                  FolderModel(title: "채권", subfolders: []),
                                                  FolderModel(title: "계좌", subfolders: [])
                                                 ])
    }
}
