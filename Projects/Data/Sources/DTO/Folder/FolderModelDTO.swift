//
//  FolderModelDTO.swift
//  Data
//
//  Created by 유현진 on 12/8/24.
//

import Foundation

struct FolderModelDTO: Codable{
    let id: StringValue
    let title: StringValue
    let subfolders: ArrayValue<StringValue>
    let URLs: ArrayValue<StringValue>
    
    enum RootKey: String, CodingKey {
        case fields
    }
    
    enum codingKey: String, CodingKey {
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
}
