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
    @State private var toast: ToastModel? = ToastModel.sampleModel
    
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
            
            // TODO: 링크 저장 유도하는 토스트
            // 링크가 있을 때 뷰 생성
            // 토스트 생성 시 백그라운드 뷰 그림자
            // 위에서 올라와야 함
            // 시간이 지나거나,
        }
        .overlay {
            VStack(){
                Spacer()
                mainToastView()
                    .frame(height: 100)
            }
            .padding(.horizontal)
            .transition(.move(edge: .bottom))
        }
        .onChange(of: toast) { newToast in
            
        }
    }
    
    @ViewBuilder func mainToastView() -> some View {
        if let toast = toast {
            VStack {
                Spacer()
                ToastView(url: toast.url)
            }
            .transition(.move(edge: .bottom))
        }
    }
}


#Preview {
    MainTabView()
}
