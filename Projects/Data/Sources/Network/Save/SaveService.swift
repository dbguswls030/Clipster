//
//  SaveService.swift
//  Data
//
//  Created by 유현진 on 12/3/24.
//

import Foundation
import Moya
import Domain

enum SaveService {
    // MARK: URL
    case fetchURLMetadata(url: URL)
    case makeURLClip(model: URLClipModelDTO)
    // MARK: Folder
    case makeFolder(documentId: String, model: FolderModelDTO)
    case fetchFolder
    case saveURLClip(folderId: String, URLClipId: String)
}

extension SaveService: TargetType{
    public var projectId: String{
        Config.firebaseProjectId
    }
    
    public var baseURL: URL {
        switch self{
        case .fetchURLMetadata(let url): url
        default: URL(string: "https://firestore.googleapis.com/v1")!
        }
    }
    
    public var path: String{
        switch self{
        case .fetchURLMetadata: ""
        case .makeFolder(let documentId, _): "/projects/\(projectId)/databases/(default)/documents/folders/\(documentId)"
        case .fetchFolder: "/projects/\(projectId)/databases/(default)/documents/folders"
        case .makeURLClip(let model): "/projects/\(projectId)/databases/(default)/documents/URLs/\(model.id.value)"
        case .saveURLClip: "/projects/\(projectId)/databases/(default)/documents:commit"
        }
    }
    
    public var method: Moya.Method{
        switch self{
        case .fetchURLMetadata: .get
        case .makeURLClip: .patch
        case .makeFolder: .patch
        case .fetchFolder: .get
        case .saveURLClip: .post
        }
    }
    
    public var task: Task{
        switch self{
        case .fetchURLMetadata: .requestPlain
        case .makeURLClip(let model): .requestJSONEncodable(["fields" : model])
        case .makeFolder(_, let model): .requestJSONEncodable(["fields" : model])
        case .fetchFolder: .requestPlain
        case .saveURLClip(let folderId, let URLClipId): .requestData(FirestoreQuery.addURLClipId(newURLClipId: URLClipId, targetField: "URLs", folderId: folderId)!)
        }
    }
    
    public var headers: [String : String]?{
        switch self{
        case .fetchURLMetadata: nil
        default: ["Content-Type": "application/json",
                  "Accept" : "application/json"]
        }
    }
}
