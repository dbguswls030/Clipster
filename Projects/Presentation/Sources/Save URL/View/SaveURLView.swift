//
//  SaveURLView.swift
//  Presentation
//
//  Created by 유현진 on 11/25/24.
//

import SwiftUI
import UIKit

struct SaveURLView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var viewModel: SaveURLViewModel
    
    var body: some View {
        NavigationStack{
            ScrollView{
                LazyVStack(alignment: .center, spacing: 30){
                    URLSectionView(viewModel: viewModel)
                    URLDescriptionView(description: $viewModel.description)
                    FolderSectionView(viewModel: viewModel)
                }
            }
            .navigationTitle("업로드")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.backward")
                            .foregroundStyle(.black)
                    }
                }
            }
            .toolbar {
                Button{
                    viewModel.makeURLClipModel()
                } label: {
                    Text("저장")
                }
                .disabled(!viewModel.isAbleToSave())
            }
        }
    }
}
extension UINavigationController: @retroactive ObservableObject, @retroactive UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self 
    }

    open func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}

//#Preview {
//    SaveURLView(viewModel: SaveURLViewModel(clipBoardURL: ""))
//}
