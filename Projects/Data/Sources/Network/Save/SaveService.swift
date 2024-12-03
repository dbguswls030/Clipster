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
}

extension SaveService: TargetType{
    public var baseURL: URL {
        switch self{
        case .fetchURLMetadata(let url): url
        }
    }
    
//    public var accessToken: String{
//        return KeyChainManager.read(key: .runningHiAccessTokenkey)!
//    }
    
    public var path: String{
        switch self{
        case .fetchURLMetadata: ""
        }
    }
    
    public var method: Moya.Method{
        switch self{
        case .fetchURLMetadata(url: let url): .get
        }
    }
    
    public var task: Task{
        switch self{
        case .fetchURLMetadata: .requestPlain
        }
    }
    
    public var headers: [String : String]?{
        switch self{
        case .fetchURLMetadata: nil
        }
    }
}
