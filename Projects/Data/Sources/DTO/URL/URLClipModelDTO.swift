//
//  URLClipModelDTO.swift
//  Data
//
//  Created by 유현진 on 12/9/24.
//

import Foundation
import Domain

struct URLClipModelDTO: Codable{
    public let id: StringValue
    public let folderId: StringValue
    public let URL: StringValue
    public let description: StringValue
    public let metaData: MapValue
    public let createDate: TimeStampValue
    
    enum RootKey: String, CodingKey {
        case fields
    }
    
    enum FieldKeys: String, CodingKey {
        case id
        case folderId
        case URL
        case description
        case metaData
        case createDate
    }
    
    init(model: URLClipModel) {
        self.id = StringValue(value: model.id)
        self.folderId = StringValue(value: model.folderId)
        self.URL = StringValue(value: model.URL.absoluteString)
        self.description = StringValue(value: model.description)
        self.metaData = MapValue(value:
                                    FieldValue(value: [
                                        "title" : StringValue(value: model.metaData.title ?? ""),
                                        "description" : StringValue(value: model.metaData.description ?? ""),
                                        "thumbnailImageURL" : StringValue(value: model.metaData.thumbnailImageURL?.absoluteString ?? "")
                                    ]))
        self.createDate = TimeStampValue(value: ISO8601DateFormatter().string(from: Date()))
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: RootKey.self)
        let fieldContainer = try container.nestedContainer(keyedBy: FieldKeys.self, forKey: .fields)
        self.id = try fieldContainer.decode(StringValue.self, forKey: .id)
        self.folderId = try fieldContainer.decode(StringValue.self, forKey: .folderId)
        self.URL = try fieldContainer.decode(StringValue.self, forKey: .URL)
        self.description = try fieldContainer.decode(StringValue.self, forKey: .description)
        self.metaData = try fieldContainer.decode(MapValue.self, forKey: .metaData)
        self.createDate = try fieldContainer.decode(TimeStampValue.self, forKey: .createDate)
    }
    
    func toEntity() -> URLClipModel{
        return URLClipModel(id: id.value,
                            folderId: folderId.value,
                            URL: Foundation.URL(string: URL.value)!,
                            description: description.value,
                            metaData: URLMetaData(title: metaData.value.fields["title"]?.value,
                                                  description: metaData.value.fields["description"]?.value,
                                                  thumbnailImageURL: metaData.value.fields["thumbnailImageURL"].flatMap{ Foundation.URL(string: $0.value)}))
    }
}
