//
//  FolderModel.swift
//  Presentation
//
//  Created by 유현진 on 11/28/24.
//

import Foundation

struct FolderModel: Identifiable{
    var id: UUID
    var name: String
    var children: [FolderModel]?
    
    init(id: UUID = UUID(), name: String, children: [FolderModel]) {
        self.id = id
        self.name = name
        self.children = children
    }
    
    static var sampleData1: FolderModel{
        return FolderModel(name: "경제", children: [FolderModel(name: "IT", children: [FolderModel(name: "문학", children: [])]),
                                                  FolderModel(name: "옷", children: []),
                                                  FolderModel(name: "유튜브", children: [])
                                                 ])
    }
    static var sampleData2: FolderModel{
        return FolderModel(name: "주식", children: [FolderModel(name: "아시아", children: [FolderModel(name: "한국", children: [])]),
                                                  FolderModel(name: "채권", children: []),
                                                  FolderModel(name: "계좌", children: [])
                                                 ])
    }
}
