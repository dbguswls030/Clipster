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
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.arrayValue = try container.decode([String: [T]].self, forKey: .arrayValue)
    }
}
struct FieldValue: Codable {
    var fields: [String: StringValue]
    
    private enum CodingKeys: String, CodingKey {
        case fields
    }
    
    init(value: [String: StringValue]) {
        self.fields = value
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.fields = try container.decode([String: StringValue].self, forKey: .fields)
    }
}

struct DocumentsValue: Codable {
    var value: [FieldValue]
    
    private enum CodingKeys: String, CodingKey {
        case value = "documents"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.value = try container.decode([FieldValue].self, forKey: .value)
    }
}

struct Documents<T: Codable>: Codable {
    let documents: T
    
    private enum CodingKeys: String, CodingKey {
        case documents
    }
}
