//
//  MyDIContainer.swift
//  Clipper
//
//  Created by 유현진 on 12/31/24.
//

import Foundation
import Domain
import Data
import Presentation

public class MyDIContainer: MyDIContainerProtocol{
    public func makeMyViewModel() -> MyViewModel {
        let repository = MyRepository()
        let useCase = MyUseCase(repository: repository)
        return MyViewModel(useCase: useCase)
    }
}
