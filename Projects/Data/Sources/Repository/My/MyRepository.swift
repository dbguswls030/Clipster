//
//  MyRepository.swift
//  Data
//
//  Created by 유현진 on 12/17/24.
//

import Foundation
import Combine
import Domain
import FirebaseAuth

enum MyError: Error{
    case signOutError
}
final public class MyRepository: MyRepositoryProtocol{
    public init() {}
    
    public func signOut() -> AnyPublisher<Void, Error>{
        return Future{ promise in
            let firebaseAuth = Auth.auth()
            do {
                try firebaseAuth.signOut()
                promise(.success(()))
            } catch let signOutError as NSError {
                print("Error signing out: %@", signOutError)
                promise(.failure(MyError.signOutError))
            }
        }
        .eraseToAnyPublisher()
        
    }
}
