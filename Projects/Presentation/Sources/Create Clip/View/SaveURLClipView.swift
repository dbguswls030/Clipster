//
//  SaveURLClipView.swift
//  Presentation
//
//  Created by 유현진 on 11/19/24.
//

import SwiftUI

struct SaveURLClipView: View {
    @StateObject var viewModel = VerifyURLViewModel()
    // TODO: 토스트 뷰에서 바로 들어올 때 URL 있어야 함
    var body: some View {
        Form{
            Section(content: {
                // TODO: URL 관련 정보 보이기
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
    SaveURLClipView()
}
