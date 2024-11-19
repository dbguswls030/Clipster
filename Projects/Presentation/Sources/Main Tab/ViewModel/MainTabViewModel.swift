//
//  MainTabViewModel.swift
//  Presentation
//
//  Created by 유현진 on 11/18/24.
//

import SwiftUI

final class MainTabViewModel: ObservableObject{
    
    @Published var selection: TabCase = .clips
    @Published var hasPasteBoard: Bool = false
    @Published var pastedURL: URL? = nil
    @Published var toast: ToastModel? = nil
    
    init(){
        bind()
    }
    
    func bind(){
        $hasPasteBoard
            .compactMap { $0 ? UIPasteboard.general.url : nil }
            .removeDuplicates(by: { $0?.absoluteString == $1?.absoluteString })
            .assign(to: &$pastedURL)
        
        $pastedURL
            .compactMap{$0}
            .removeDuplicates()
            .map{ ToastModel(url: $0) }
            .assign(to: &$toast)
    }
    
    func handleScenePhaseChange(_ phase: ScenePhase){
        DispatchQueue.main.async { [weak self] in
            self?.hasPasteBoard = phase == .active && UIPasteboard.general.hasURLs
        }
    }
}
