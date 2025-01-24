//
//  EditFolderView.swift
//  Presentation
//
//  Created by 유현진 on 1/21/25.
//

import SwiftUI
import Domain

struct EditFolderView: View {
    @StateObject var viewModel: EditFolderViewModel
    let clipDIContainer: ClipDIContainerProtocol
    
    @Environment(\.dismiss) private var dismiss
    @FocusState private var isFocused: Bool
    @Binding private var isUpdateFolder: Bool
    
    init(clipDIContainer: ClipDIContainerProtocol, folderModel: FolderModel, isUpdateFolder: Binding<Bool>) {
        self.clipDIContainer = clipDIContainer
        self._viewModel = .init(wrappedValue: clipDIContainer.makeEditFolderViewModel(folderModel: folderModel))
        self._isUpdateFolder = isUpdateFolder
    }
    
    var body: some View {
        ScrollView{
            VStack(alignment: .leading, spacing: 10){
                Text("📁 폴더 수정")
                    .font(.title2)
                    .bold()
                    .foregroundStyle(.black)
                
                GroupBox{
                    TextField(text: $viewModel.editTitleText) {
                        Text("수정할 폴더 이름을 입력해 주세요.")
                    }
                    .focused($isFocused)
                    .onChange(of: viewModel.editTitleText) { newValue in
                        if newValue.count > 10{
                            DispatchQueue.main.async {
                                self.viewModel.editTitleText = String(newValue.prefix(10))
                            }
                        }
                    }
                }
                HStack{
                    Spacer()
                    Text("\(viewModel.folderModel.title.count)/10")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                Spacer()
            }
        }
        .onTapGesture {
            isFocused = false
        }
        .padding()
        .navigationTitle("폴더 수정")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button {
                viewModel.editFolderTitle(newTitle: viewModel.editTitleText)
            } label: {
                Text("수정")
            }
            .disabled(viewModel.editTitleText.isEmpty && viewModel.editTitleText == viewModel.folderModel.title)
        }
        .onChange(of: viewModel.isSuccess) { newValue in
            if newValue {
                isUpdateFolder = true
                dismiss()
            }
        }
    }
}

//#Preview {
//    EditFolderView()
//}
