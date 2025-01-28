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
        ScrollView{
            LazyVStack(alignment: .leading, spacing: 30){
                HStack{
                    Text("🔗 링크")
                        .font(.title2)
                        .bold()
                        .foregroundStyle(.black)
                        .padding(.leading)
                    Spacer()
                }
                GroupBox{
                    Button(action: {
                        openURL(viewModel.URLClipModel.URL)
                    }) {
                        PreViewURLView(metaData: .constant(viewModel.URLClipModel.metaData))
                    }
                }
                .padding(.horizontal)
                
                HStack{
                    HStack{
                        Text("📝 메모")
                            .font(.title2)
                            .bold()
                            .foregroundStyle(.black)
                            .padding(.leading)
                        Spacer()
                    }
                }
                GroupBox{
                    Text(viewModel.URLClipModel.description)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .multilineTextAlignment(.leading)
                        
                }
                .padding(.horizontal)
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

