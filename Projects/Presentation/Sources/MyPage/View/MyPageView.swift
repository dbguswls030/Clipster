//
//  MyPageView.swift
//  Presentation
//
//  Created by 유현진 on 11/16/24.
//

import SwiftUI

public struct MyPageView: View {
    @StateObject var viewModel: MyViewModel
    
    public init(viewModel: MyViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    public var body: some View {
        Button {
            viewModel.signOut()
        } label: {
            Text("로그아웃")
        }

    }
}
