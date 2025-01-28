//
//  ClipDetailViewModel.swift
//  Presentation
//
//  Created by 유현진 on 1/12/25.
//

import Foundation
import Domain

final public class ClipDetailViewModel: ObservableObject{
    
    let useCase: ClipUseCaseProtocol
    var URLClipModel: URLClipModel
    
    public init(useCase: ClipUseCaseProtocol, URLClipModel: URLClipModel) {
        self.useCase = useCase
        self.URLClipModel = URLClipModel
    }
    
    @Published var isShowingAlert: Bool = false
    @Published var isRemoveURLClip: Bool = false
    
    func removeURLClip(){
        Task{
            do{
                try await useCase.removeURLClip(model: URLClipModel)
                
                await MainActor.run {
                    isRemoveURLClip = true
                }
            }catch{
                print(error.localizedDescription)
            }
        }
    }
    
    func clearRemoveClipProperty(){
        isShowingAlert = false
    }
}
