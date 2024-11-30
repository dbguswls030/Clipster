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
    @State private var isPresentSaveURL: Bool = false
    
    public init() {}
    
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
            .toastView(toast: $viewModel.toast, isPresentSaveURL: $isPresentSaveURL)
            .navigationDestination(isPresented: $isPresentSaveURL) {
                SaveURLView(viewModel: SaveURLViewModel(clipBoardURL: viewModel.pastedURL?.absoluteString ?? ""))
            }
            
        }
    }
}

#Preview {
    MainTabView()
}
