//
//  MyClipView.swift
//  Presentation
//
//  Created by 유현진 on 11/16/24.
//

import SwiftUI

struct MyClipView: View {
    @StateObject var viewModel: MyClipViewModel
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
        }
    }
}
