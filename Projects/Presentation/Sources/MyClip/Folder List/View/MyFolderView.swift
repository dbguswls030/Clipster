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
                NavigationLink(destination: ClipListView(clipDIContainer: clipDIContainer, folderId: item.id, updateMyFolders: $viewModel.updateMyFolders)) {
                    MyFolderRow(folder: item)
                }
            }
//            .onDelete { indexSet in
//                viewModel.isShowingAlert = true
//                viewModel.deleteFolderIndex = indexSet
//            }
            .alert(isPresented: $viewModel.isShowingAlert) {
                Alert(title: Text("폴더 삭제"),
                      message: Text("폴더와 폴더 안에 저장된 내용이 모두 삭제됩니다. 정말 삭제하시겠습니까?"),
                      primaryButton: .destructive(
                        Text("삭제"),
                        action: {
                            guard let indexSet = viewModel.deleteFolderIndex else { return }
                            viewModel.removeFolder(at: indexSet)
                            viewModel.clearDeleteProperty()
                        }),
                      secondaryButton: .cancel(
                        Text("취소"),
                        action: {
                            viewModel.clearDeleteProperty()
                        })
                )
            }
        }
        .refreshable(action: {
            viewModel.fetchFolders()
        })
        .toolbar {
            HStack{
                NavigationLink {
                    MakeFolderView(clipDIContainer: clipDIContainer, isUpdateFolder: $viewModel.updateMyFolders)
                } label: {
                    Image(systemName: "folder.badge.plus")
                        .foregroundStyle(.black)
                }
                
                NavigationLink {
                    SaveURLView(clipDIContainer: clipDIContainer)
                } label: {
                    Image(systemName: "plus")
                        .foregroundStyle(.black)
                }
            }
        }
    }
}
