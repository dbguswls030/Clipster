//
//  MyFolderView.swift
//  Presentation
//
//  Created by 유현진 on 11/16/24.
//

import SwiftUI

struct MyFolderView: View {
    @StateObject var viewModel: MyFolderViewModel
    let clipDIContainer: ClipDIContainerProtocol
    
    init(clipDIContainer: ClipDIContainerProtocol) {
        self.clipDIContainer = clipDIContainer
        self._viewModel = .init(wrappedValue: clipDIContainer.makeClipViewModel())
    }
    
    var body: some View {
        List{
            ForEach(viewModel.folders) { item in
                NavigationLink(destination: ClipListView(clipDIContainer: clipDIContainer, folderModel: item)) {
                    MyFolderRow(folder: item)
                }
            }
        }
        .toolbar {
            NavigationLink {
                MakeFolderView(clipDIContainer: clipDIContainer, isUpdateFolder: $viewModel.isUpdateFolders)
            } label: {
                Image(systemName: "folder.badge.plus")
                    .foregroundStyle(.black)
            }
        }
    }
}
