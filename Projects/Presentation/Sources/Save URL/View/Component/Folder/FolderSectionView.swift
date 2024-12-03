//
//  FolderSectionView.swift
//  Presentation
//
//  Created by 유현진 on 11/27/24.
//

import SwiftUI

struct FolderSectionView: View {
    @ObservedObject var viewModel: SaveURLViewModel
    
    var body: some View {
        VStack(spacing: 15){
            HStack{
                Text("📁 폴더")
                    .font(.title2)
                    .bold()
                    .foregroundStyle(.black)
                    .padding(.leading)
                Spacer()
            }
            GroupBox{
                FolderListView(viewModel: FolderViewModel(folderHierachy: $viewModel.folderHierachy, selection: $viewModel.selectedFolder, expandedFolders: $viewModel.expandedFolders))
            }
            .padding(.horizontal)
        }
    }
}

//#Preview {
//    ScrollView{
//        FolderSectionView(viewModel: SaveURLViewModel(clipBoardURL: ""))
//    }
//}
