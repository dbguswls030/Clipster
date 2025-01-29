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
import Combine

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
    public func makeClipListViewModel(folderId: String) -> ClipListViewModel {
        let repository = ClipRepository()
        let useCase = ClipUseCase(repository: repository)
        return ClipListViewModel(useCase: useCase, folderId: folderId)
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
    public func makeEditFolderViewModel(folderModel: FolderModel) -> EditFolderViewModel {
        let repository = ClipRepository()
        let useCase = ClipUseCase(repository: repository)
        return EditFolderViewModel(useCase: useCase, folderModel: folderModel)
    }
    public func makeEditClipViewModel(URLClipModel: URLClipModel) -> EditClipViewModel {
        let repository = ClipRepository()
        let useCase = ClipUseCase(repository: repository)
        return EditClipViewModel(useCase: useCase, URLClipModel: URLClipModel)
    }
}
