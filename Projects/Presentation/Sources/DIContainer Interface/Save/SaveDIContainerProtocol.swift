//
//  SaveDIContainerProtocol.swift
//  Presentation
//
//  Created by 유현진 on 12/3/24.
//

import Foundation

public protocol SaveDIContainerProtocol{
    func makeSaveDIContainer(clipBoardURL: String) -> SaveURLViewModel
    func makeSaveDIContainer() -> SaveURLViewModel
    
}
