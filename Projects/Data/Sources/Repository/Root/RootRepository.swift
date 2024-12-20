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
    private let authStateSubject = PassthroughSubject<Bool, Never>()
    private var authStateListenerHandle: AuthStateDidChangeListenerHandle?
    
    public init(){
        authStateListenerHandle = Auth.auth().addStateDidChangeListener{ [weak self] _, user in
            self?.authStateSubject.send(user != nil)
        }
    }
    
    public func authStateListener() -> AnyPublisher<Bool, Never>{
        return authStateSubject.eraseToAnyPublisher()
    }
}
