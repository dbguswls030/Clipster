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
    
    enum CodingKeys: String, CodingKey{
        case id
    }
    
    init(id: String) {
        self.id = id
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
    }
}
