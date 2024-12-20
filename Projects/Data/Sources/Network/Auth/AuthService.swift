//
//  AuthService.swift
//  Data
//
//  Created by 유현진 on 12/19/24.
//

import Foundation
import Moya
import Domain

enum AuthService{
    case checkIsExistedUser(uid: String)
    case createUser(model: UserModelDTO)
}

extension AuthService: TargetType{
    public var projectId: String{
        Config.firebaseProjectId
    }
    
    public var baseURL: URL {
        switch self{
        default: URL(string: "https://firestore.googleapis.com/v1")!
        }
    }
    
    public var path: String{
        switch self{
        case .checkIsExistedUser(let uid): "/projects/\(projectId)/databases/(default)/documents/users/\(uid)"
        case .createUser(let model): "/projects/\(projectId)/databases/(default)/documents/users/\(model.id.value)"
        }
    }
    
    public var method: Moya.Method{
        switch self{
        case .checkIsExistedUser: .get
        case .createUser: .patch
        }
    }
    
    public var task: Task{
        switch self{
        case .checkIsExistedUser: .requestPlain
        case .createUser(let model): .requestJSONEncodable(["fields" : model])
        }
    }
    
    public var headers: [String : String]?{
        switch self{
        default: ["Content-Type": "application/json",
                  "Accept" : "application/json"]
        }
    }
}
