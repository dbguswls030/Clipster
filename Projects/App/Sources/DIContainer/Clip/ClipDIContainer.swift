//
//  ClipDIContainer.swift
//  Clipper
//
//  Created by 유현진 on 12/31/24.
//

import Foundation
import Domain
import Data
import Presentation

public class ClipDIContainer: ClipDIContainerProtocol{
    public func makeSaveViewModel() -> SaveURLViewModel {
        let repository = ClipRepository()
        let useCase = ClipUseCase(repository: repository)
        return SaveURLViewModel(useCase: useCase)
    }
    public func makeSaveViewModel(clipBoardURL: String) -> SaveURLViewModel {
        let repository = ClipRepository()
        let useCase = ClipUseCase(repository: repository)
        return SaveURLViewModel(useCase: useCase, clipBoradURL: clipBoardURL)
    }
    public func makeClipViewModel() -> MyFolderViewModel {
        let repository = ClipRepository()
        let useCase = ClipUseCase(repository: repository)
        return MyFolderViewModel(useCase: useCase)
    }
    public func makeClipListViewModel(folderModel: FolderModel) -> ClipListViewModel {
        let repository = ClipRepository()
        let useCase = ClipUseCase(repository: repository)
        return ClipListViewModel(useCase: useCase, folderModel: folderModel)
    }
    public func makeClipDetailViewModel(URLClipModel: URLClipModel) -> ClipDetailViewModel{
        let repository = ClipRepository()
        let useCase = ClipUseCase(repository: repository)
        return ClipDetailViewModel(useCase: useCase, URLClipModel: URLClipModel)
    }
    public func makeMakeFolderViewModel() -> MakeFolderViewModel{
        let repository = ClipRepository()
        let useCase = ClipUseCase(repository: repository)
        return MakeFolderViewModel(useCase: useCase)
    }
}
