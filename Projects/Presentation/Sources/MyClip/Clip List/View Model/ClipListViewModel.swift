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
    @Published var updateClipList: Bool = false
    @Published var isRemoveFolder: Bool = false
    @Published var isShowingAlert: Bool = false
    
    @Published var updateFromClipDetail: Bool = false
    
    private func bind(){
        fetchURLs()
        
        $updateClipList
            .filter{$0}
            .sink { [weak self] _ in
                self?.fetchFolder()
            }.store(in: &cancellables)
        
        $updateFromClipDetail
            .filter{$0}
            .sink { [weak self] _ in
                self?.fetchURLs()
            }.store(in: &cancellables)
    }
    
    func fetchURLs(){
        Task{
            do{
                let newFolder = try await useCase.fetchFolder(folderId: folderId)
                let newModels = try await useCase.fetchURLClips(urls: newFolder.URLs)
                await MainActor.run {
                    folderModel = newFolder
                    urlClips = newModels
                    updateFromClipDetail = false
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
                    updateClipList = false
                }
            }catch{
                print(error.localizedDescription)
            }
        }
    }
    
    func removeFolder(){
        guard let folderModel = folderModel else { return }
        Task{
            do{
                try await useCase.removeFolder(folder: folderModel)
                await MainActor.run{
                    isRemoveFolder = true
                }
            }catch{
                print(error.localizedDescription)
            }
        }
    }
    
    func removeClip(at offsets: IndexSet){
        guard let index = offsets.first else { return }
        
        let removeURLClipModel = urlClips[index]
        folderModel?.URLs.remove(atOffsets: offsets)
        urlClips.remove(atOffsets: offsets)
    
        guard let folderModel = folderModel else { return }
        
        
        Task{
            do{
                try await useCase.removeURLClip(model: removeURLClipModel)
                
                let newModels = try await useCase.fetchURLClips(urls: folderModel.URLs)
                await MainActor.run {
                    urlClips = newModels
                }
            }catch{
                print(error.localizedDescription)
            }
        }
    }
    
    func clearRemoveFolderProperty(){
        isShowingAlert = false
    }
}
