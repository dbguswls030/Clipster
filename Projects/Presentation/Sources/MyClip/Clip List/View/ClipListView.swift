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
    
    init(clipDIContainer: ClipDIContainerProtocol, folderModel: FolderModel) {
        self.clipDIContainer = clipDIContainer
        self._viewModel = .init(wrappedValue: clipDIContainer.makeClipListViewModel(folderModel: folderModel))
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
