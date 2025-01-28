//
//  EditClipView.swift
//  Presentation
//
//  Created by 유현진 on 1/28/25.
//

import SwiftUI
import Domain

struct EditClipView: View {
    @StateObject var viewModel: EditClipViewModel
    let clipDIContainer: ClipDIContainerProtocol
    
    @Environment(\.dismiss) private var dismiss
    @Binding private var editURLClip: Bool
    @FocusState private var isFocused: Bool
    
    init(clipDIContainer: ClipDIContainerProtocol, editURLClip: Binding<Bool>, URLClipModel: URLClipModel) {
        self.clipDIContainer = clipDIContainer
        self._viewModel = .init(wrappedValue: clipDIContainer.makeEditClipViewModel(URLClipModel: URLClipModel))
        self._editURLClip = editURLClip
    }
    
    var body: some View {
        ScrollView{
            VStack(alignment: .leading, spacing: 30){
                VStack{
                    HStack{
                        Text("🔗 링크")
                            .font(.title2)
                            .bold()
                            .foregroundStyle(.black)
                        Spacer()
                    }
                    GroupBox{
                        PreViewURLView(metaData: $viewModel.metaData)
                            .padding(.bottom, 10)
                    }
                }
                VStack{
                    HStack{
                        Text("📁 메모 수정")
                            .font(.title2)
                            .bold()
                            .foregroundStyle(.black)
                        Spacer()
                    }
                    GroupBox{
                        TextEditor(text: $viewModel.editDescription)
                            .onChange(of: viewModel.editDescription) { desc in
                                if desc.count > 100 { // 제한할 글자수
                                    DispatchQueue.main.async {
                                        self.viewModel.editDescription = String(desc.prefix(100))
                                    }
                                }
                            }
                            .focused($isFocused)
                            .overlay(alignment: .topLeading){
                                Text("수정할 메모를 작성해 주세요.")
                                    .foregroundStyle(viewModel.editDescription.isEmpty ? .gray : .clear)
                                    .fontWeight(.medium)
                                    .padding([.top, .leading], 8)
                            }
                            .frame(height: 100)
                            .scrollContentBackground(.hidden)
                            .background(Color(.systemGray6))
                            .fontWeight(.medium)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 15, trailing: 0))
                            .overlay(alignment: .bottomTrailing) {
                                Text("\(viewModel.editDescription.count)/100")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                    }
                }
            }
        }
        .onTapGesture {
            isFocused = false
        }
        .padding()
        .navigationTitle("클립 수정")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button {
                viewModel.editURLClip(newDescription: viewModel.editDescription)
            } label: {
                Text("수정")
            }
            .disabled(viewModel.editDescription.isEmpty && viewModel.editDescription == viewModel.urlClipModel.description)
        }
        .onChange(of: viewModel.isSuccess) { newValue in
            if newValue {
                editURLClip = true
                dismiss()
            }
        }
    }
}

//#Preview {
//    EditClipView()
//}
