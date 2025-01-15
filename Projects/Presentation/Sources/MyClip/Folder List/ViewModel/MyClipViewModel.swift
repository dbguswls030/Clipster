//
//  MyClipViewModel.swift
//  Presentation
//
//  Created by 유현진 on 1/5/25.
//

import Foundation
import Domain
import Combine

final public class MyClipViewModel: ObservableObject{
    private var cancellables = Set<AnyCancellable>()
    
    let useCase: ClipUseCaseProtocol
    
    public init(useCase: ClipUseCaseProtocol) {
        self.useCase = useCase
        bind()
    }
    
    @Published var folders: [FolderModel] = []
    
    @Published var isUpdateFolders: Bool = false
    
    private func bind(){
        fetchFolders()
        observerIsUpdateFolders()
    }
    
    private func fetchFolders(){
        Task{
            do{
                let fetchFolder = try await useCase.fetchFolder()
                await MainActor.run {
                    folders = fetchFolder
                    isUpdateFolders = false
                }
            }catch{
                print(error.localizedDescription)
            }
        }
    }
    
    private func observerIsUpdateFolders(){
        $isUpdateFolders
            .filter{$0}
            .sink { [weak self] _ in
                self?.fetchFolders()
            }
            .store(in: &cancellables)
    }
}
