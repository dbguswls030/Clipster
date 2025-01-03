//
//  DIContainerProtocol.swift
//  Presentation
//
//  Created by 유현진 on 12/14/24.
//

import Foundation

public protocol DIContainerProtocol{
    func makeAuthDIContainer() -> AuthDIContainerProtocol
    func makeRootDIContainer() -> RootDIContainerProtocol
    func makeMyDIContainer() -> MyDIContainerProtocol
    func makeSaveDIContainer() -> SaveDIContainerProtocol
}
