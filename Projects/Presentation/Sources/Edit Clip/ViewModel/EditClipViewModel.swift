//
//  EditClipViewModel.swift
//  Presentation
//
//  Created by 유현진 on 1/28/25.
//

import Foundation
import Domain

final public class EditClipViewModel: ObservableObject{
    let useCase: ClipUseCaseProtocol
    var urlClipModel: URLClipModel
    var metaData: URLMetaData?
    
    public init(useCase: ClipUseCaseProtocol, URLClipModel: URLClipModel) {
        self.useCase = useCase
        self.urlClipModel = URLClipModel
        self.metaData = URLClipModel.metaData
        self.editDescription = URLClipModel.description
    }
    
    @Published var editDescription: String
    @Published var isSuccess: Bool = false
    
    func editURLClip(newDescription: String){
        Task{
            do{
                try await useCase.editURLClip(model: urlClipModel, description: newDescription)
                await MainActor.run {
                    isSuccess = true
                }
            }catch{
                print(error.localizedDescription)
            }
        }
    }
}
