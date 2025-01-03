//
//  RootDIContainer.swift
//  Clipper
//
//  Created by 유현진 on 12/31/24.
//

import Foundation
import Domain
import Presentation
import Data

public class RootDIContainer: RootDIContainerProtocol {
    public func makeRootViewModel() -> RootViewModel {
        let repository = RootRepository()
        let useCase = RootUseCase(repository: repository)
        return RootViewModel(useCase: useCase)
    }
}
