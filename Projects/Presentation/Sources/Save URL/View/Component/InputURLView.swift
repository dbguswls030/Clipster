//
//  InputURLView.swift
//  Presentation
//
//  Created by 유현진 on 11/26/24.
//

import SwiftUI
import Combine

struct InputURLView: View {
    @ObservedObject var viewModel: InputURLViewModel
    
    var body: some View {
        HStack{
            Group{
                if viewModel.isLoading {
                    ProgressView()
                        .scaleEffect(0.7)
                }else{
                    Image(systemName: viewModel.URLStateSystemImage)
                        .foregroundStyle(viewModel.URLStateImageForegroundColor)
                }
            }
            .frame(width: 20, height: 20)
            .padding(.trailing, 5)
            
            TextField("링크를 붙혀넣기 해 주세요.", text: $viewModel.url)
            
            if !viewModel.url.isEmpty{
                Button {
                    viewModel.clearURL()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(.black)
                }
            }
        }
    }
}

#Preview {
    InputURLView(viewModel: InputURLViewModel(isLoading: .constant(true), url: .constant(""), isInvalidURL: .constant(false)))
}
