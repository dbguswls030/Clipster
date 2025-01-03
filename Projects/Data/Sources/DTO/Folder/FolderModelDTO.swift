//
//  FolderModelDTO.swift
//  Data
//
//  Created by 유현진 on 12/8/24.
//

import Foundation
import Domain

struct FolderModelDTO: Codable{
    let id: String
    let title: String
    let subfolders: [String]
    let URLs: [String]
    let uid: String
    
    enum CodingKeys: String, CodingKey{
        case id, title, subfolders, URLs, uid
    }
    
    init(id: String = UUID().uuidString, title: String, subfolders: [String], URLs: [String], uid: String) {
        self.id = id
        self.title = title
        self.subfolders = subfolders
        self.URLs = URLs
        self.uid = uid
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.subfolders = try container.decode([String].self, forKey: .subfolders)
        self.URLs = try container.decode([String].self, forKey: .URLs)
        self.uid = try container.decode(String.self, forKey: .uid)
    }
    
    func toEntity() -> FolderModel{
        return FolderModel(id: id,
                           title: title,
                           uid: uid)
    }
}
