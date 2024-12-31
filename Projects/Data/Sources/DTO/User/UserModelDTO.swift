//
//  UserModelDTO.swift
//  Data
//
//  Created by 유현진 on 12/20/24.
//

import Foundation
import Domain

struct UserModelDTO: Codable{
    let id: StringValue
    let folders: ArrayValue<StringValue>
    
    enum RootKey: String, CodingKey {
        case fields
    }
    
    enum FieldKeys: String, CodingKey {
        case id
        case folders
    }
    
    init(id: String, folders: [String] = []) {
        self.id = StringValue(value: id)
        self.folders = ArrayValue(values: folders.map{StringValue(value:$0)})
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: RootKey.self)
        let fieldContainer = try container.nestedContainer(keyedBy: FieldKeys.self, forKey: .fields)
        self.id = try fieldContainer.decode(StringValue.self, forKey: .id)
        self.folders = try fieldContainer.decode(ArrayValue<StringValue>.self, forKey: .folders)
    }
}
