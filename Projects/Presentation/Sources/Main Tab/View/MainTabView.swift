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
    @State private var pastedURL: URL?
    
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
        }
    }
}


#Preview {
    MainTabView()
}
