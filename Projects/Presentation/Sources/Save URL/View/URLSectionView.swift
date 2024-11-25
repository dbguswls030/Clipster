//
//  URLSectionView.swift
//  Presentation
//
//  Created by 유현진 on 11/19/24.
//

import SwiftUI

struct URLSectionView: View {
    @ObservedObject var viewModel: SaveURLViewModel
    // TODO: 토스트 뷰에서 바로 들어올 때 URL 있어야 함
    var body: some View {
        Section{
            VStack(spacing: 10){
                PreViewURLView(metaData: $viewModel.metaData)
                TextField("링크를 붙혀넣기 해 주세요.", text: $viewModel.url)
                    .background {
                        viewModel.backgroundColor
                    }
                    
            }
        } header: {
            Text("링크")
                .font(.title2)
                .bold()
                .foregroundStyle(.black)
        }
    }
}

#Preview {
    URLSectionView(viewModel: SaveURLViewModel(clipBoardURL: ""))
}
