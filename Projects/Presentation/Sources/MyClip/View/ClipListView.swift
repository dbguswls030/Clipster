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
    let saveDIContainer: SaveDIContainerProtocol
    
    init(saveDIContainer: SaveDIContainerProtocol, folderModel: FolderModel) {
        self.saveDIContainer = saveDIContainer
        self._viewModel = .init(wrappedValue: saveDIContainer.makeClipListViewModel(folderModel: folderModel))
    }
    
    var body: some View {
        List{
            ForEach(viewModel.urlClips){ item in
                ClipRow(metaData: .constant( item.metaData))
            }
        }
        .navigationTitle(viewModel.folderModel.title)
        
    }
}
