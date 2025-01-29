//
//  EditFolderViewModel.swift
//  Presentation
//
//  Created by 유현진 on 1/21/25.
//

import Foundation
import Domain

final public class EditFolderViewModel: ObservableObject{
    let useCase: ClipUseCaseProtocol
    var folderModel: FolderModel
    
    public init(useCase: ClipUseCaseProtocol, folderModel: FolderModel) {
        self.useCase = useCase
        self.folderModel = folderModel
        self.editTitleText = folderModel.title
    }
    
    @Published var isSuccess: Bool = false
    @Published var editTitleText: String
    
    func editFolderTitle(newTitle: String){
        Task{
            do{
                try await useCase.editFolderTitle(folderId: folderModel.id, editedTitle: newTitle)
                await MainActor.run {
                    isSuccess = true
                }
            }catch{
                print(error.localizedDescription)
            }
        }
    }
}
