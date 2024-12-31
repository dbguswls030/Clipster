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
    @ObservedObject var rootRouter = AppRouter()
    
    public init(DIContainer: DIContainerProtocol) {
        self.DIContainer = DIContainer
        self._viewModel = StateObject(wrappedValue: DIContainer.makeRootDIContainer().makeRootViewModel())
    }
    
    public var body: some View {
        Group{
            switch rootRouter.currentRoute {
            case .login:
                LoginView(viewModel: DIContainer.makeAuthDIContainer().makeAuthViewModel(), router: rootRouter)
            case .mainTab:
                MainTabView(DIContainer: DIContainer, router: rootRouter)
            }
        }
        .animation(.easeInOut, value: rootRouter.currentRoute)
        .onChange(of: viewModel.isLoggedIn) { newValue in
            switch newValue{
            case true: rootRouter.currentRoute = .mainTab
            case false: rootRouter.currentRoute = .login
            }
        }
    }
}
