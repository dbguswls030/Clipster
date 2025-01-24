//
//  ClipListView.swift
//  Presentation
//
//  Created by 유현진 on 1/7/25.
//

import SwiftUI
import Domain

struct ClipListView: View {
    @StateObject var viewModel: ClipListViewModel
    let clipDIContainer: ClipDIContainerProtocol
    @Binding private var isUpdateFolder: Bool
    
    init(clipDIContainer: ClipDIContainerProtocol, folderId: String, isUpdatedFolders: Binding<Bool>) {
        self.clipDIContainer = clipDIContainer
        self._viewModel = .init(wrappedValue: clipDIContainer.makeClipListViewModel(folderId: folderId))
        self._isUpdateFolder = isUpdatedFolders
    }
    
    var body: some View {
        List{
            ForEach(viewModel.urlClips){ item in
                NavigationLink(destination: ClipDetailView(clipDIContainer: clipDIContainer, URLClipModel: item)) {
                    PreViewURLView(metaData: .constant(item.metaData))
                }
            }
        }
        .navigationTitle(viewModel.folderModel?.title ?? "Loading...")
        .toolbar {
            if let folderModel = viewModel.folderModel{
                Menu {
                    NavigationLink(destination: EditFolderView(clipDIContainer: clipDIContainer, folderModel: folderModel, isUpdateFolder: $viewModel.isUpdatedFolder)){
                        HStack{
                            Text("폴더 수정")
                            Image(systemName: "pencil.circle")
                        }
                    }

                    Button(role: .destructive) {
                        
                    } label: {
                        HStack{
                            Text("폴더 삭제")
                            Image(systemName: "trash")
                        }
                    }
                    
                } label: {
                    Image(systemName: "ellipsis.circle")
                        .foregroundStyle(.black)
                }
            }
        }
        .onChange(of: viewModel.isUpdatedFolder) { newValue in
            if newValue{
                isUpdateFolder = true
            }
        }
    }
}
