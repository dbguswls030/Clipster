//
//  MainTabView.swift
//  Presentation
//
//  Created by 유현진 on 11/16/24.
//

import SwiftUI

public struct MainTabView: View {
    
    @StateObject private var viewModel = MainTabViewModel()
    @Environment(\.scenePhase) private var scenePhase
    
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
        .onChange(of: scenePhase, perform: viewModel.handleScenePhaseChange)
        .onChange(of: viewModel.hasPasteBoard, perform: viewModel.pasteURL)
        .onChange(of: viewModel.pastedURL, perform: viewModel.makeURL)
        .overlay {
            ZStack(){
                mainToastView()
            }.animation(.spring, value: viewModel.toast)
                .padding(.horizontal)
        }
        .onChange(of: viewModel.toast, perform: { _ in viewModel.showToast() })
    }
    
    @ViewBuilder func mainToastView() -> some View {
        if let toast = viewModel.toast {
            VStack {
                Spacer()
                ToastView(url: toast.url)
                    .frame(height: 100)
            }
            .transition(.move(edge: .bottom))
        }
    }
}

#Preview {
    MainTabView()
}
