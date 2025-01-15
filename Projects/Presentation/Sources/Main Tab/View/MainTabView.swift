//
//  MainTabView.swift
//  Presentation
//
//  Created by 유현진 on 11/16/24.
//

import SwiftUI

public struct MainTabView: View {
    @Environment(\.scenePhase) private var scenePhase
    @StateObject private var viewModel = MainTabViewModel()
    @ObservedObject var rootRouter = AppRouter()
    let DIContainer: DIContainerProtocol
    
    public init(DIContainer: DIContainerProtocol, router: AppRouter) {
        self.DIContainer = DIContainer
        self.rootRouter = router
    }
    
    public var body: some View {
        NavigationStack{
            TabView(selection: $viewModel.selection){
                MyFolderView(clipDIContainer: DIContainer.makeClipDIContainer())
                    .tabItem {
                        Label("clips", systemImage: "star")
                    }
                    .tag(TabCase.clips)
                
                MyPageView(viewModel: DIContainer.makeMyDIContainer().makeMyViewModel(), router: rootRouter)
                    .tabItem{
                        Label("My", systemImage: "star.fill")
                    }
                    .tag(TabCase.myPage)
            }
            .navigationTitle(viewModel.selection == .clips ? "나의 폴더" : "마이페이지")
        }
        .onChange(of: scenePhase) { phase in
            viewModel.handleScenePhaseChange(phase)
        }
        .toastView(toast: $viewModel.toast, isPresentSaveURL: $viewModel.isPresentSaveURL)
        .sheet(isPresented: $viewModel.isPresentSaveURL) {
            SaveURLView(viewModel: DIContainer.makeClipDIContainer().makeSaveViewModel(clipBoardURL: viewModel.pastedURL?.absoluteString ?? ""))
                .onAppear{
                    viewModel.isShowingSaveURLView = true
                }
                .onDisappear{
                    viewModel.isShowingSaveURLView = false
                }
        }
    }
}

//#Preview {
//    MainTabView(DIContainer: SaveDIContainerProtocol)
//}
