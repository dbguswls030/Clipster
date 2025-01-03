//
//  URLClipModelDTO.swift
//  Data
//
//  Created by 유현진 on 12/9/24.
//

import Foundation
import Domain
import FirebaseFirestore

struct URLClipModelDTO: Codable{
    public let id: String
    public let uid: String
    public let folderId: String
    public let URL: String
    public let description: String
    public let metaData: [String: String]
    public let createAt: Timestamp
    
    enum CodingKeys: String, CodingKey {
        case id
        case uid
        case folderId
        case URL
        case description
        case metaData
        case createAt
    }
    
    init(model: URLClipModel) {
        self.id = model.id
        self.uid = model.uid
        self.folderId = model.folderId
        self.URL = model.URL.absoluteString
        self.description = model.description
        self.metaData = [
            "title" : model.metaData.title ?? "",
            "description" : model.metaData.description ?? "",
            "thumbnailImageURL" : model.metaData.thumbnailImageURL?.absoluteString ?? ""
        ]
        self.createAt = Timestamp(date: Date())
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.uid = try container.decode(String.self, forKey: .uid)
        self.folderId = try container.decode(String.self, forKey: .folderId)
        self.URL = try container.decode(String.self, forKey: .URL)
        self.description = try container.decode(String.self, forKey: .description)
        self.metaData = try container.decode([String : String].self, forKey: .metaData)
        self.createAt = try container.decode(Timestamp.self, forKey: .createAt)
    }
    
    func toEntity() -> URLClipModel{
        return URLClipModel(id: id,
                            uid: uid,
                            folderId: folderId,
                            URL: Foundation.URL(string: URL)!,
                            description: description,
                            metaData: URLMetaData(title: metaData["title"],
                                                  description: metaData["description"],
                                                  thumbnailImageURL: metaData["thumbnailImageURL"].flatMap{ Foundation.URL(string: $0)}),
                            createAt: createAt.dateValue())
    }
}
