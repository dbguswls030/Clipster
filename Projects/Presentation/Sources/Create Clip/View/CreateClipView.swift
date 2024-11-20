//
//  CreateClipView.swift
//  Presentation
//
//  Created by 유현진 on 11/19/24.
//

import SwiftUI

struct CreateClipView: View {
    @StateObject var viewModel = VerifyURLViewModel()
    
    var body: some View {
        Form{
            Section(content: {
                // TODO: URL
                TextField("링크를 입력해 주세요.", text: $viewModel.url)
            }, header: {
                Text("링크")
                    .font(.title)
                    .bold()
                    .foregroundStyle(.black)
            })
        }
    }
    
    // TODO: 폴더 선택
    // TODO: 폴더 
}

#Preview {
    CreateClipView()
}
