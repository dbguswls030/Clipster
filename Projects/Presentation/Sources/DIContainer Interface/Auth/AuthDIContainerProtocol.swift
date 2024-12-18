//
//  AuthDIContainerProtocol.swift
//  Presentation
//
//  Created by 유현진 on 12/13/24.
//

import Foundation

public protocol AuthDIContainerProtocol{
    func makeAuthDIContainer() -> LoginViewModel
}
