//
//  ClipDetailView.swift
//  Presentation
//
//  Created by 유현진 on 1/11/25.
//

import SwiftUI
import Domain

struct ClipDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var viewModel: ClipDetailViewModel
    let clipDIContainer: ClipDIContainerProtocol
    @Binding var updateClipList: Bool
    
    init(clipDIContainer: ClipDIContainerProtocol, URLClipModel: URLClipModel, updateFromClipDetail: Binding<Bool>) {
        self.clipDIContainer = clipDIContainer
        self._viewModel = .init(wrappedValue: clipDIContainer.makeClipDetailViewModel(URLClipModel: URLClipModel))
        self._updateClipList = updateFromClipDetail
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
        .toolbar {
            Menu {
                NavigationLink(destination: EditClipView(clipDIContainer: clipDIContainer, editURLClip: $viewModel.editURLClip, URLClipModel: viewModel.URLClipModel)){
                    HStack{
                        Text("클립 수정")
                        Image(systemName: "pencil.circle")
                    }
                }
                
                Button(role: .destructive) {
                    viewModel.isShowingAlert = true
                } label: {
                    HStack{
                        Text("클립 삭제")
                        Image(systemName: "trash")
                    }
                }
                
            } label: {
                Image(systemName: "ellipsis.circle")
                    .foregroundStyle(.black)
            }
            
        }
        .alert(isPresented: $viewModel.isShowingAlert) {
            Alert(title: Text("클립 삭제"),
                  message: Text("정말 삭제하시겠습니까?"),
                  primaryButton: .destructive(
                    Text("삭제"),
                    action: {
                        viewModel.removeURLClip()
                        viewModel.clearRemoveClipProperty()
                    }),
                  secondaryButton: .cancel(
                    Text("취소"),
                    action: {
                        viewModel.clearRemoveClipProperty()
                    })
            )
        }
        .onChange(of: viewModel.isRemoveURLClip) { newValue in
            if newValue{
                updateClipList = true
                dismiss()
            }
        }
        .onChange(of: viewModel.editURLClip){ newValue in
            if newValue{
                updateClipList = true
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

