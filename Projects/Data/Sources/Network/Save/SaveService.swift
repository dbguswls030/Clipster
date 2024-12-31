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
    case saveFolderIdInUser(uid: String, folderId: String)
    case fetchMyFolder(folderIds: [String])
    case saveURLClip(folderId: String, URLClipId: String)
    // MARK: In User
    case fetchMyFolderIds(uid: String)
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
        case .saveFolderIdInUser: "/projects/\(projectId)/databases/(default)/documents:commit"
        case .fetchMyFolder: "/projects/\(projectId)/databases/(default)/documents/folders"
        case .makeURLClip(let model): "/projects/\(projectId)/databases/(default)/documents/URLs/\(model.id.value)"
        case .saveURLClip: "/projects/\(projectId)/databases/(default)/documents:commit"
        case .fetchMyFolderIds(let uid): "/projects/\(projectId)/databases/(default)/documents/users/\(uid)"
        }
    }
    
    public var method: Moya.Method{
        switch self{
        case .fetchURLMetadata: .get
        case .makeURLClip: .patch
        case .makeFolder: .patch
        case .saveFolderIdInUser: .post
        case .fetchMyFolder: .get
        case .saveURLClip: .post
        case .fetchMyFolderIds: .get
        }
    }
    
    public var task: Task{
        switch self{
        case .fetchURLMetadata: .requestPlain
        case .makeURLClip(let model): .requestJSONEncodable(["fields" : model])
        case .makeFolder(_, let model): .requestJSONEncodable(["fields" : model])
        case .saveFolderIdInUser(let uid, let folderId): .requestData(FirestoreQuery.addFolderIdInUser(newFolderId: folderId, uid: uid)!)
        case .fetchMyFolder(let folderIds): .requestParameters(parameters: FirestoreQuery.foldersFilter(folderIds: folderIds), encoding: URLEncoding.queryString)
        case .saveURLClip(let folderId, let URLClipId): .requestData(FirestoreQuery.addURLClipIdInFolder(newURLClipId: URLClipId, folderId: folderId)!)
        case .fetchMyFolderIds: .requestPlain
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
