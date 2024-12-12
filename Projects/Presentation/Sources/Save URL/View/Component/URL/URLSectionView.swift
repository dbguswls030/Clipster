//
//  URLSectionView.swift
//  Presentation
//
//  Created by 유현진 on 11/19/24.
//

import SwiftUI

struct URLSectionView: View {
    @ObservedObject var viewModel: SaveURLViewModel
    
    var body: some View {
        VStack(spacing: 20){
            HStack{
                Text("🔗 링크")
                    .font(.title2)
                    .bold()
                    .foregroundStyle(.black)
                    .padding(.leading)
                Spacer()
            }
            GroupBox{
                PreViewURLView(metaData: $viewModel.metaData)
                    .padding(.bottom, 10)
                InputURLView(viewModel: InputURLViewModel(
                    isLoading: $viewModel.isLoadingForTextField,
                    url: $viewModel.url,
                    isInvalidURL: $viewModel.isInvalidURL))   
            }
            .padding(.horizontal)
        }
    }
}

//#Preview {
//    URLSectionView(viewModel: SaveURLViewModel(clipBoardURL: ""))
//}
