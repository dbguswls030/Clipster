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
    
    init(id: String, folders: [String] = []) {
        self.id = StringValue(value: id)
        self.folders = ArrayValue(values: folders.map{StringValue(value:$0)})
    }
}
