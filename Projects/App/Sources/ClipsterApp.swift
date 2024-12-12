//
//  ClipsterApp.swift
//  Clipster
//
//  Created by 유현진 on 11/15/24.
//

import SwiftUI
import Presentation

@main
struct ClipsterApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup{
            MainTabView(DIContainer: DIContainer())
        }
    }
}
