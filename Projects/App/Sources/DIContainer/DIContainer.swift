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
    
    public func makeSaveDIContainer() -> SaveURLViewModel{
        let repository = SaveRepository()
        let useCase = SaveUseCase(repository: repository)
        return SaveURLViewModel(useCase: useCase)
    }
}
