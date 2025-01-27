//
//  ClipListView.swift
//  Presentation
//
//  Created by 유현진 on 1/7/25.
//

import SwiftUI
import Domain

struct ClipListView: View {
    @Environment(\.dismiss) private var dismiss
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
            .onDelete { indexSet in
                viewModel.removeClip(at: indexSet)
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
                        viewModel.isShowingAlert = true
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
        .onChange(of: viewModel.isRemoveFolder) { newValue in
            if newValue{
                isUpdateFolder = true
                dismiss()
            }
        }
        .alert(isPresented: $viewModel.isShowingAlert) {
            Alert(title: Text("폴더 삭제"),
                  message: Text("폴더와 폴더 안에 저장된 내용이 모두 삭제됩니다. 정말 삭제하시겠습니까?"),
                  primaryButton: .destructive(
                    Text("삭제"),
                    action: {
                        viewModel.removeFolder()
                        viewModel.clearRemoveFolderProperty()
                    }),
                  secondaryButton: .cancel(
                    Text("취소"),
                    action: {
                        viewModel.clearRemoveFolderProperty()
                    })
            )
        }
    }
}
