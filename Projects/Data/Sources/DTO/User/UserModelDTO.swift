//
//  UserModelDTO.swift
//  Data
//
//  Created by 유현진 on 12/20/24.
//

import Foundation
import Domain

struct UserModelDTO: Codable{
    let id: String
    let folders: [String]
    
    enum CodingKeys: String, CodingKey{
        case id
        case folders
    }
    
    init(id: String, folders: [String] = []) {
        self.id = id
        self.folders = folders
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.folders = try container.decode([String].self, forKey: .folders)
    }
}
