//
//  DIContainer.swift
//  Clipper
//
//  Created by 유현진 on 12/3/24.
//

import Foundation
import Domain
import Presentation
import Data

final public class DIContainer: DIContainerProtocol{
    
    public init(){ }
    
    public func makeAuthDIContainer() -> AuthDIContainerProtocol {
        return AuthDIContainer()
    }
    
    public func makeMyDIContainer() -> MyDIContainerProtocol {
        return MyDIContainer()
    }
    
    public func makeRootDIContainer() -> RootDIContainerProtocol {
        return RootDIContainer()
    }
    
    public func makeClipDIContainer() -> ClipDIContainerProtocol {
        return ClipDIContainer()
    }
}
