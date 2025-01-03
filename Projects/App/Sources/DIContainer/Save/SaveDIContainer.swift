//
//  SaveDIContainer.swift
//  Clipper
//
//  Created by 유현진 on 12/31/24.
//

import Foundation
import Domain
import Data
import Presentation

public class SaveDIContainer: SaveDIContainerProtocol{
    public func makeSaveViewModel() -> SaveURLViewModel {
        let repository = SaveRepository()
        let useCase = SaveUseCase(repository: repository)
        return SaveURLViewModel(useCase: useCase)
    }
    public func makeSaveViewModel(clipBoardURL: String) -> SaveURLViewModel {
        let repository = SaveRepository()
        let useCase = SaveUseCase(repository: repository)
        return SaveURLViewModel(useCase: useCase, clipBoradURL: clipBoardURL)
    }
}
