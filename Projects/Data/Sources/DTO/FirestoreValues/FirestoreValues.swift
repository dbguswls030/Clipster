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
    let arrayValue: ArrayWrapper<T>

    init(values: [T]) {
        self.arrayValue = ArrayWrapper(values: values)
    }

    enum CodingKeys: String, CodingKey {
        case arrayValue
    }
}

struct ArrayWrapper<T: Codable>: Codable {
    let values: [T]

    enum CodingKeys: String, CodingKey {
        case values
    }
}
