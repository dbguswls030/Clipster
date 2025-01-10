//
//  MyClipView.swift
//  Presentation
//
//  Created by 유현진 on 11/16/24.
//

import SwiftUI

struct MyClipView: View {
    @StateObject var viewModel: MyClipViewModel
    let saveDIContainer: SaveDIContainerProtocol
    
    init(saveDIContainer: SaveDIContainerProtocol) {
        self.saveDIContainer = saveDIContainer
        self._viewModel = .init(wrappedValue: saveDIContainer.makeClipViewModel())
    }
    var body: some View {
        NavigationStack{
            List{
                ForEach(viewModel.folders) { item in
                    NavigationLink(destination: ClipListView(saveDIContainer: saveDIContainer, folderModel: item)) {
                        MyFolderRow(folder: item)
                    }
                }
            }
            .navigationTitle("나의 폴더")
        }
    }
}
