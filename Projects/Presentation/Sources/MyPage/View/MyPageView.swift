//
//  MyPageView.swift
//  Presentation
//
//  Created by 유현진 on 11/16/24.
//

import SwiftUI

public struct MyPageView: View {
    @StateObject var viewModel: MyViewModel
    @ObservedObject var rootRouter = AppRouter()
    
    public init(viewModel: MyViewModel, router: AppRouter) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self.rootRouter = router
    }
    
    public var body: some View {
        VStack(spacing: 10){
            Button {
                viewModel.logout()
            } label: {
                Text("로그아웃")
            }
            
            Button {
                viewModel.signout()
            } label: {
                Text("회원탈퇴")
            }
        }
        .onChange(of: viewModel.isExited) { newValue in
            if newValue { rootRouter.currentRoute = .login }
        }
    }
}
