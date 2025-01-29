//
//  ClipDIContainerProtocol.swift
//  Presentation
//
//  Created by 유현진 on 12/3/24.
//

import Foundation
import Domain
import Combine

public protocol ClipDIContainerProtocol{
    func makeSaveViewModel(clipBoardURL: String) -> SaveURLViewModel
    func makeSaveViewModel() -> SaveURLViewModel
    func makeClipViewModel() -> MyFolderViewModel
    func makeClipListViewModel(folderId: String) -> ClipListViewModel
    func makeClipDetailViewModel(URLClipModel: URLClipModel) -> ClipDetailViewModel
    func makeMakeFolderViewModel() -> MakeFolderViewModel
    func makeEditFolderViewModel(folderModel: FolderModel) -> EditFolderViewModel
    func makeEditClipViewModel(URLClipModel: URLClipModel) -> EditClipViewModel
}
