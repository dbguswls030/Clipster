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
            FolderRowView(folder: item, selectedFolderID: $viewModel.selection, expandedFolders: $viewModel.expandedFolders)
        }
//        List(viewModel.$folderHierachy, children: \.children, selection: $viewModel.selection){ item in
//            FolderRowView(title: item.name, isSelected: viewModel.selection == item.id)
//        }
//        .listStyle(.plain)
    }
}

#Preview {
    ScrollView{
        FolderListView(viewModel: FolderViewModel(folderHierachy: .constant([FolderModel.sampleData1]), selection: .constant(nil), expandedFolders: .constant(Set<UUID>())))
    }
}
