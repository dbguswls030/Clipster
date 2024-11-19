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

    public init() {}    
    public var body: some View {
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
            .toastView(toast: $viewModel.toast)
    }
}

#Preview {
    MainTabView()
}
