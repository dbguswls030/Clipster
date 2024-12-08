//
//  FolderModelDTO.swift
//  Data
//
//  Created by 유현진 on 12/8/24.
//

import Foundation
import Domain

struct FolderModelDTO: Codable{
    let id: StringValue
    let title: StringValue
    let subfolders: ArrayValue<StringValue>
    let URLs: ArrayValue<StringValue>
    
    enum RootKey: String, CodingKey {
        case fields
    }
    
    enum FieldKeys: String, CodingKey {
        case id
        case title
        case subfolders
        case URLs
    }
    
    init(id: String = UUID().uuidString, title: String, subfolders: [String], URLs: [String]) {
        self.id = StringValue(value: id)
        self.title = StringValue(value: title)
        self.subfolders = ArrayValue(values: subfolders.map { StringValue(value: $0) })
        self.URLs = ArrayValue(values: URLs.map { StringValue(value: $0) })
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: RootKey.self)
        let fieldContainer = try container.nestedContainer(keyedBy: FieldKeys.self, forKey: .fields)
        self.id = try fieldContainer.decode(StringValue.self, forKey: .id)
        self.title = try fieldContainer.decode(StringValue.self, forKey: .title)
        self.subfolders = try fieldContainer.decode(ArrayValue<StringValue>.self, forKey: .subfolders)
        self.URLs = try fieldContainer.decode(ArrayValue<StringValue>.self, forKey: .URLs)
    }
    
    func toEntity() -> FolderModel{
        return FolderModel(id: id.value,
                           title: title.value)
    }
}
