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

    init(id: String = UUID().uuidString, title: String, subfolders: [String], URLs: [String]) {
        self.fields = Fields(
            id: StringValue(value: id),
            title: StringValue(value: title),
            subfolders: ArrayValue(values: subfolders.map { StringValue(value: $0) }),
            URLs: ArrayValue(values: URLs.map { StringValue(value: $0) })
        )
    }
}

extension FolderModelDTO{
    struct Fields: Codable {
        let id: StringValue
        let title: StringValue
        let subfolders: ArrayValue<StringValue>
        let URLs: ArrayValue<StringValue>
    }
}
