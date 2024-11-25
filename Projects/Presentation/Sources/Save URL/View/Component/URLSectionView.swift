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
                InputURLView(viewModel: viewModel)
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
