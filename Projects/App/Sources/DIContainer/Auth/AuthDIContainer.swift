//
//  AuthDIContainer.swift
//  Clipper
//
//  Created by 유현진 on 12/31/24.
//

import Foundation
import Domain
import Data
import Presentation

public class AuthDIContainer: AuthDIContainerProtocol{
    public func makeAuthViewModel() -> LoginViewModel {
        let repository = AuthRepository()
        let useCase = AuthUseCase(repository: repository)
        return LoginViewModel(useCase: useCase)
    }
}
