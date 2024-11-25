//
//  SaveURLView.swift
//  Presentation
//
//  Created by 유현진 on 11/25/24.
//

import SwiftUI

struct SaveURLView: View {
    @StateObject var viewModel: SaveURLViewModel
    
    var body: some View {
        NavigationStack{
            Form{
                URLSectionView(viewModel: viewModel)
            }
            .navigationTitle("업로드")
            .navigationBarTitleDisplayMode(.inline)
        }
        
    }
}

#Preview {
    SaveURLView(viewModel: SaveURLViewModel(clipBoardURL: ""))
}
