//
//  ClipDIContainerProtocol.swift
//  Presentation
//
//  Created by 유현진 on 12/3/24.
//

import Foundation
import Domain

public protocol ClipDIContainerProtocol{
    func makeSaveViewModel(clipBoardURL: String) -> SaveURLViewModel
    func makeSaveViewModel() -> SaveURLViewModel
    func makeClipViewModel() -> MyFolderViewModel
    func makeClipListViewModel(folderModel: FolderModel) -> ClipListViewModel
    func makeClipDetailViewModel(URLClipModel: URLClipModel) -> ClipDetailViewModel
    func makeMakeFolderViewModel() -> MakeFolderViewModel
}
