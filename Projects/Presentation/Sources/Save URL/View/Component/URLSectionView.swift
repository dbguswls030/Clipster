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
        Section{
            VStack(spacing: 10){
                PreViewURLView(metaData: $viewModel.metaData)
                    .padding(.bottom, 10)
                InputURLView(viewModel: InputURLViewModel(
                    isLoading: $viewModel.isLoading,
                    url: $viewModel.url,
                    isInvalidURL: $viewModel.isInvalidURL))
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
    Form{
        URLSectionView(viewModel: SaveURLViewModel(clipBoardURL: ""))
    }
    
}
