//
//  MainTabView.swift
//  Presentation
//
//  Created by 유현진 on 11/16/24.
//

import SwiftUI

public struct MainTabView: View {
    @Environment(\.scenePhase) private var scenePhase
    @State private var selection: TabCase = .clips
    @State private var hasPasteBoard: Bool = false
    @State private var pastedURL: URL? = nil
    @State private var toast: ToastModel? = nil
    @State private var workItem: DispatchWorkItem?
    public init() {}
    
    public var body: some View {
        
        TabView(selection: $selection){
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
            if phase == .active, UIPasteboard.general.hasURLs{
                hasPasteBoard = true
            }else if phase == .background{
                hasPasteBoard = false
            }
        }
        .onChange(of: hasPasteBoard) {
            if $0{
                if pastedURL != UIPasteboard.general.url{
                    pastedURL = UIPasteboard.general.url
                }
            }
        }
        .onChange(of: pastedURL) { newPastedURL in
            print(newPastedURL)
            if let newURL = newPastedURL{
                toast = ToastModel(url: newURL)
            }
        }
        .overlay {
            ZStack(){
                mainToastView()
            }.animation(.spring, value: toast)
                .padding(.horizontal)
        }
        .onChange(of: toast) { newToast in
            showToast()
        }
    }
    
    @ViewBuilder func mainToastView() -> some View {
        if let toast = toast {
            VStack {
                Spacer()
                ToastView(url: toast.url)
                    .frame(height: 100)
            }
            .transition(.move(edge: .bottom))
        }
    }
    
    private func showToast() {
        guard let toast = toast else { return }
        
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        
        if toast.duration > 0 {
            workItem?.cancel()
            
            let task = DispatchWorkItem {
                dismissToast()
            }
            
            workItem = task
            DispatchQueue.main.asyncAfter(deadline: .now() + toast.duration, execute: task)
        }
    }
    
    private func dismissToast() {
        withAnimation {
            toast = nil
        }
        
        workItem?.cancel()
        workItem = nil
    }
}

#Preview {
    MainTabView()
}
