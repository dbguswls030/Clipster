//
//  FirestoreQuery.swift
//  Data
//
//  Created by 유현진 on 12/12/24.
//

import Foundation

struct FirestoreQuery{
    static func addURLClipIdInFolder(newURLClipId: String, folderId: String) -> Data? {
        return """
        {
            "writes": {
                "transform": {
                    "document": "projects/\(Config.firebaseProjectId)/databases/(default)/documents/folders/\(folderId)",
                    "fieldTransforms": [
                        {
                            "appendMissingElements": {
                                "values": [
                                    {
                                        "stringValue": "\(newURLClipId)"
                                    }
                                ]
                            },
                            "fieldPath": "URLs"
                        }
                    ]
                }
            }
        }
        """.data(using: .utf8)
    }
    
    static func addFolderIdInUser(newFolderId: String, uid: String) -> Data?{
        return """
        {
            "writes": {
                "transform": {
                    "document": "projects/\(Config.firebaseProjectId)/databases/(default)/documents/users/\(uid)",
                    "fieldTransforms": [
                        {
                            "appendMissingElements": {
                                "values": [
                                    {
                                        "stringValue": "\(newFolderId)"
                                    }
                                ]
                            },
                            "fieldPath": "folders"
                        }
                    ]
                }
            }
        }
        """.data(using: .utf8)
    }
    
    static func foldersFilter(folderIds: [String]) -> [String: Any]{
        let query: [String: Any] = [
            "where": [
                "fieldFilter": [
                    "field": ["fieldPath": "folderId"],
                    "op": "IN",
                    "values": folderIds.map { ["stringValue": $0] }
                ]
            ]
        ]
        return query
    }
}
