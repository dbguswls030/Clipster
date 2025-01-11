//
//  ClipListViewModel.swift
//  Presentation
//
//  Created by 유현진 on 1/8/25.
//

import Foundation
import Domain
import Combine

final public class ClipListViewModel: ObservableObject{
    
    let useCase: ClipUseCaseProtocol
    let folderModel: FolderModel
    
    public init(useCase: ClipUseCaseProtocol, folderModel: FolderModel) {
        self.useCase = useCase
        self.folderModel = folderModel
        bind()
    }
    
    @Published var urlClips: [URLClipModel] = []
    
    private func bind(){
        fetchURLs()
    }
    
    func fetchURLs(){
        Task{
            do{
                let newModels = try await useCase.fetchURLs(urls: folderModel.URLs)
                await MainActor.run {
                    urlClips = newModels
                }
            }catch{
                print(error.localizedDescription)
            }
        }
    }
}
