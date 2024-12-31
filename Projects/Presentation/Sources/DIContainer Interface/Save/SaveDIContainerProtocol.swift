//
//  SaveDIContainerProtocol.swift
//  Presentation
//
//  Created by 유현진 on 12/3/24.
//

import Foundation

public protocol SaveDIContainerProtocol{
    func makeSaveViewModel(clipBoardURL: String) -> SaveURLViewModel
    func makeSaveViewModel() -> SaveURLViewModel
}
