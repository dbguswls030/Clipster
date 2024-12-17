//
//  RootView.swift
//  Presentation
//
//  Created by 유현진 on 12/14/24.
//

import SwiftUI

public struct RootView: View {
    let DIContainer: DIContainerProtocol
    
    @StateObject var viewModel: RootViewModel
    
    public init(DIContainer: DIContainerProtocol) {
        self.DIContainer = DIContainer
        self._viewModel = StateObject(wrappedValue: DIContainer.makeRootDIContainer())
    }

    public var body: some View {
        if viewModel.isLoggedIn{
            MainTabView(DIContainer: DIContainer)
        }else{
            LoginView(viewModel: DIContainer.makeAuthDIContainer())
        }
    }
}
