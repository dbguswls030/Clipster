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
    
//    public var accessToken: String{
//        return KeyChainManager.read(key: .runningHiAccessTokenkey)!
//    }
    
    public var path: String{
        switch self{
        case .fetchURLMetadata: ""
        case .makeFolder(let requestModel): "/projects/\(projectId)/databases/(default)/documents/folders"
        }
    }
    
    public var method: Moya.Method{
        switch self{
        case .fetchURLMetadata: .get
        case .makeFolder: .post
        }
    }
    
    public var task: Task{
        switch self{
        case .fetchURLMetadata: .requestPlain
        case .makeFolder(let requestModel): .requestJSONEncodable(requestModel)
        }
    }
    
    public var headers: [String : String]?{
        switch self{
        case .fetchURLMetadata: nil
        case .makeFolder: ["Content-Type": "application/json"]
        }
    }
}
