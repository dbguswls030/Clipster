//
//  ClipDetailViewModel.swift
//  Presentation
//
//  Created by 유현진 on 1/12/25.
//

import Foundation
import Domain
import Combine

final public class ClipDetailViewModel: ObservableObject{
    private var cancellables = Set<AnyCancellable>()
    
    let useCase: ClipUseCaseProtocol
    @Published var URLClipModel: URLClipModel
    
    public init(useCase: ClipUseCaseProtocol, URLClipModel: URLClipModel) {
        self.useCase = useCase
        self.URLClipModel = URLClipModel
        bind()
    }
    
    @Published var isShowingAlert: Bool = false
    @Published var isRemoveURLClip: Bool = false
    
    @Published var editURLClip: Bool = false
    
    func bind(){
        $editURLClip
            .filter{$0}
            .sink { [weak self] _ in
                self?.fetchURLClipModel()
            }.store(in: &cancellables)
    }
    
    
    func fetchURLClipModel(){
        Task{
            do{
                let newModel = try await useCase.fetchURLClip(id: URLClipModel.id)
                await MainActor.run {
                    URLClipModel = newModel
                    editURLClip = false
                }
            }catch{
                print(error.localizedDescription)
            }
        }
    }
    
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
