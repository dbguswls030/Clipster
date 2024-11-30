//
//  FolderListView.swift
//  Presentation
//
//  Created by 유현진 on 11/27/24.
//

import SwiftUI

struct FolderListView: View {
    @ObservedObject var viewModel: FolderViewModel
    
    var body: some View {
        ForEach(viewModel.folderHierachy) { item in
            FolderRowView(folder: item, selectedFolderID: $viewModel.selectedFolderId, expandedFolders: $viewModel.expandedFolders)
        }
    }
}

#Preview {
    ScrollView{
        FolderListView(viewModel: FolderViewModel(folderHierachy: .constant([FolderModel.sampleData1]), selection: .constant(nil), expandedFolders: .constant(Set<UUID>())))
    }
}
