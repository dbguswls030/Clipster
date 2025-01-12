//
//  ClipDetailView.swift
//  Presentation
//
//  Created by 유현진 on 1/11/25.
//

import SwiftUI
import Domain

struct ClipDetailView: View {
    @StateObject var viewModel: ClipDetailViewModel
    let clipDIContainer: ClipDIContainerProtocol
    
    init(clipDIContainer: ClipDIContainerProtocol, URLClipModel: URLClipModel) {
        self.clipDIContainer = clipDIContainer
        self._viewModel = .init(wrappedValue: clipDIContainer.makeClipDetailViewModel(URLClipModel: URLClipModel))
    }
    
    var body: some View {
        List{
            LazyVStack(alignment: .leading, spacing: 10){
                Button(action: {
                    openURL(viewModel.URLClipModel.URL)
                }) {
                    PreViewURLView(metaData: .constant(viewModel.URLClipModel.metaData))
                }
                Text(viewModel.URLClipModel.description)
            }
        }
    }
}
extension ClipDetailView{
    private func openURL(_ url: URL) {
        guard UIApplication.shared.canOpenURL(url) else {
            print("Invalid URL")
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}

