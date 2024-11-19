//
//  MainTabViewModel.swift
//  Presentation
//
//  Created by 유현진 on 11/18/24.
//

import SwiftUI

final class MainTabViewModel: ObservableObject{
    
    @Published var selection: TabCase = .clips
    @Published var toast: ToastModel? = nil
    @Published var hasPasteBoard: Bool = false
    @Published var pastedURL: URL? = nil
    
    func handleScenePhaseChange(_ phase: ScenePhase){
        if phase == .active{
            hasPasteBoard = true
        }else if phase == .background{
            hasPasteBoard = false
        }
    }
    
    func pasteURL(_ hasPasteBoard: Bool){
        if hasPasteBoard{
            if pastedURL != UIPasteboard.general.url{
                pastedURL = UIPasteboard.general.url
            }
        }
    }
    
    func makeURL(_ url: URL?){
        if let newURL = url{
            toast = ToastModel(url: newURL)
        }
    }
}
