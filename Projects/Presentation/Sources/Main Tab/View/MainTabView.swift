//
//  MainTabView.swift
//  Presentation
//
//  Created by 유현진 on 11/16/24.
//

import SwiftUI

public struct MainTabView: View {
    @State private var selection: TabCase = .clips
    
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
    }
}

#Preview {
    MainTabView()
}
