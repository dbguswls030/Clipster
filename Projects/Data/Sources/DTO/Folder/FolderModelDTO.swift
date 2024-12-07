//
//  FolderModelDTO.swift
//  Data
//
//  Created by 유현진 on 12/7/24.
//

import Foundation
import Domain

struct FolderModelDTO: Codable{
    let fields: Fields

    struct Fields: Codable {
        let id: StringValue
        let title: StringValue
        let subfolders: ArrayValue<StringValue>
        let URLs: ArrayValue<StringValue>
        
        enum FieldKeys: String, CodingKey{
            case id
            case title
            case subfolders
            case URLs
        }
    }
    enum RootKey: String, CodingKey {
        case fields
    }
    
    init(id: String = UUID().uuidString, title: String, subfolders: [String], URLs: [String]) {
        self.fields = Fields(
            id: StringValue(value: id),
            title: StringValue(value: title),
            subfolders: ArrayValue(values: subfolders.map { StringValue(value: $0) }),
            URLs: ArrayValue(values: URLs.map { StringValue(value: $0) })
        )
    }
}
