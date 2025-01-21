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
                // Folder id로 folder의 url 다시 긁어와야 함
                let newFolder = try await useCase.fetchFolder(folderId: folderModel.id)
                let newModels = try await useCase.fetchURLs(urls: newFolder.URLs)
                await MainActor.run {
                    urlClips = newModels
                }
            }catch{
                print(error.localizedDescription)
            }
        }
    }
}
