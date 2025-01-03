//
//  RootRepository.swift
//  Data
//
//  Created by 유현진 on 12/18/24.
//

import Foundation
import Domain
import FirebaseAuth

final public class RootRepository: RootRepositoryProtocol{
    
    public init(){ }
    
    public func fetchCurrentUser() async -> Bool{
        if Auth.auth().currentUser != nil{
            return true
        }else{
            return false
        }
    }
}
