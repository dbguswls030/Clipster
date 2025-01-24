//
//  ClipListViewModel.swift
//  Presentation
//
//  Created by 유현진 on 1/8/25.
//

import Foundation
import Domain
import Combine
import SwiftUI

final public class ClipListViewModel: ObservableObject{
    private var cancellables = Set<AnyCancellable>()
    
    let useCase: ClipUseCaseProtocol
    let folderId: String
    
    public init(useCase: ClipUseCaseProtocol, folderId: String) {
        self.useCase = useCase
        self.folderId = folderId
        bind()
    }
    
    @Published var urlClips: [URLClipModel] = []
    @Published var folderModel: FolderModel?
    @Published var isUpdatedFolder: Bool = false
    
    private func bind(){
        fetchURLs()
        
        $isUpdatedFolder
            .filter{$0}
            .sink { [weak self] _ in
                self?.fetchFolder()
            }.store(in: &cancellables)
    }
    
    func fetchURLs(){
        Task{
            do{
                let newFolder = try await useCase.fetchFolder(folderId: folderId)
                let newModels = try await useCase.fetchURLs(urls: newFolder.URLs)
                await MainActor.run {
                    folderModel = newFolder
                    urlClips = newModels
                }
            }catch{
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchFolder(){
        Task{
            do{
                let newFolder = try await useCase.fetchFolder(folderId: folderId)
                await MainActor.run {
                    folderModel = newFolder
                    isUpdatedFolder = false
                }
            }catch{
                print(error.localizedDescription)
            }
        }
    }
}
