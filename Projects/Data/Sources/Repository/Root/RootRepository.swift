//
//  RootRepository.swift
//  Data
//
//  Created by 유현진 on 12/18/24.
//

import Foundation
import Combine
import Domain
import FirebaseAuth

final public class RootRepository: RootRepositoryProtocol{
    
    public init(){ }
    
    public func fetchCurrentUser() -> AnyPublisher<Bool, Never> {
        return Future{ promise in
            if Auth.auth().currentUser != nil{
                promise(.success(true))
            }else{
                promise(.success(false))
            }
        }
        .eraseToAnyPublisher()
    }
}
