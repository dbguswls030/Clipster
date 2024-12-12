//
//  FirestoreQuery.swift
//  Data
//
//  Created by 유현진 on 12/12/24.
//

import Foundation

struct FirestoreQuery{
    static func addURLClipId(newURLClipId: String, targetField: String, folderId: String) -> Data? {
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
                            "fieldPath": "\(targetField)"
                        }
                    ]
                }
            }
        }
        """.data(using: .utf8)
    }
}
