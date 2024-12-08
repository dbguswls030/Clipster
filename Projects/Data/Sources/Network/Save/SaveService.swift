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
    case fetchURLMetadata(url: URL)
    case makeFolder(FolderModelDTO)
    case fetchFolder
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
        case .makeFolder(let requestModel): "/projects/\(projectId)/databases/(default)/documents/folders/\(requestModel.fields.id.value)"
        case .fetchFolder: "/projects/\(projectId)/databases/(default)/documents/folders"
        }
    }
    
    public var method: Moya.Method{
        switch self{
        case .fetchURLMetadata: .get
        case .makeFolder: .patch
        case .fetchFolder: .get
        }
    }
    
    public var task: Task{
        switch self{
        case .fetchURLMetadata: .requestPlain
        case .makeFolder(let requestModel): .requestJSONEncodable(requestModel)
        case .fetchFolder: .requestPlain
        }
    }
    
    public var headers: [String : String]?{
        switch self{
        case .fetchURLMetadata: nil
        default: ["Content-Type": "application/json"]
        }
    }
}
