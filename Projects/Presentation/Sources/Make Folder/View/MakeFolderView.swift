//
//  MakeFolderView.swift
//  Presentation
//
//  Created by 유현진 on 1/14/25.
//

import SwiftUI

struct MakeFolderView: View {
    @StateObject var viewModel: MakeFolderViewModel
    let clipDIContainer: ClipDIContainerProtocol
    
    @Environment(\.dismiss) private var dismiss
    @FocusState private var isFocused: Bool
    @Binding private var isUpdateFolder: Bool
    
    init(clipDIContainer: ClipDIContainerProtocol, isUpdateFolder: Binding<Bool>) {
        self.clipDIContainer = clipDIContainer
        self._viewModel = .init(wrappedValue: clipDIContainer.makeMakeFolderViewModel())
        self._isUpdateFolder = isUpdateFolder
    }

    var body: some View {
        ScrollView{
            VStack(alignment: .leading, spacing: 10){
                Text("📁 새 폴더")
                    .font(.title2)
                    .bold()
                    .foregroundStyle(.black)

                GroupBox{
                    TextField(text: $viewModel.folderName) {
                        Text("폴더 이름을 입력해 주세요.")
                    }
                    .focused($isFocused)
                    .onChange(of: viewModel.folderName) { newValue in
                        if newValue.count > 10{
                            DispatchQueue.main.async {
                                self.viewModel.folderName = String(newValue.prefix(10))
                            }
                        }
                    }
                }
                HStack{
                    Spacer()
                    Text("\(viewModel.folderName.count)/10")
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
        .navigationTitle("폴더 생성")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button {
                viewModel.makeFolder(newFolderName: viewModel.folderName)
            } label: {
                Text("생성")
            }
            .disabled(viewModel.folderName.isEmpty)
        }
        .onChange(of: viewModel.isSuccess) { newValue in
            if newValue {
                isUpdateFolder = true
                dismiss()
            }
        }
    }
}

