//
//  FirestoreValues.swift
//  Data
//
//  Created by 유현진 on 12/7/24.
//

import Foundation

struct StringValue: Codable{
    let value: String
    
    init(value: String) {
        self.value = value
    }
    
    enum CodingKeys: String, CodingKey{
        case value = "stringValue"
    }
}

struct ArrayValue<T: Codable>: Codable {
    let arrayValue: [String: [T]]

    init(values: [T]) {
        self.arrayValue = ["values" : values]
    }

    enum CodingKeys: String, CodingKey {
        case arrayValue
    }
}
