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
                Button(action: {
                    openURL(item.URL)
                }) {
                    ClipRow(metaData: .constant(item.metaData))
                }
            }
        }
        .navigationTitle(viewModel.folderModel.title)
    }
}
extension ClipListView{
    private func openURL(_ url: URL) {
        guard UIApplication.shared.canOpenURL(url) else {
            print("Invalid URL")
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
