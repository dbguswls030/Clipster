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
    
}

extension DIContainer: SaveDIContainerProtocol{
    public func makeSaveDIContainer(clipBoardURL: String) -> SaveURLViewModel{
        let repository = SaveRepository()
        let useCase = SaveUseCase(repository: repository)
        return SaveURLViewModel(useCase: useCase, clipBoradURL: clipBoardURL)
    }
    
    public func makeSaveDIContainer() -> SaveURLViewModel {
        let repository = SaveRepository()
        let useCase = SaveUseCase(repository: repository)
        return SaveURLViewModel(useCase: useCase)
    }
}

extension DIContainer: AuthDIContainerProtocol{
    public func makeAuthDIContainer() -> LoginViewModel {
        let repository = AuthRepository()
        let useCase = AuthUseCase(repository: repository)
        return LoginViewModel(useCase: useCase)
    }
    
    public func makeRootDIContainer() -> RootViewModel {
        let repository = AuthRepository()
        let useCase = AuthUseCase(repository: repository)
        return RootViewModel(useCase: useCase)
    }
}
