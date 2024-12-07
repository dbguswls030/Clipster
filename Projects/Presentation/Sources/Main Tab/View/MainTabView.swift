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
    
    let DIContainer: SaveDIContainerProtocol
    
    public init(DIContainer: SaveDIContainerProtocol) {
        self.DIContainer = DIContainer
    }
    
    public var body: some View {
        NavigationStack {
            TabView(selection: $viewModel.selection){
                MyClipView()
                    .tabItem {
                        Label("clips", systemImage: "star")
                    }
                    .tag(TabCase.clips)
                MyPageView()
                    .tabItem{
                        Label("My", systemImage: "star.fill")
                    }
                    .tag(TabCase.myPage)
            }
            .onChange(of: scenePhase) { phase in
                viewModel.handleScenePhaseChange(phase)
            }
            .toastView(toast: $viewModel.toast, isPresentSaveURL: $viewModel.isPresentSaveURL)
            .navigationDestination(isPresented: $viewModel.isPresentSaveURL) {
                SaveURLView(viewModel: DIContainer.makeSaveDIContainer(clipBoardURL: viewModel.pastedURL?.absoluteString ?? ""))
            }
        }
    }
}

//#Preview {
//    MainTabView(DIContainer: SaveDIContainerProtocol)
//}
