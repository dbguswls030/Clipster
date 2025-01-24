//
//  MyFolderViewModel.swift
//  Presentation
//
//  Created by 유현진 on 1/5/25.
//

import Foundation
import Domain
import Combine

final public class MyFolderViewModel: ObservableObject{
    private var cancellables = Set<AnyCancellable>()
    
    let useCase: ClipUseCaseProtocol
    
    public init(useCase: ClipUseCaseProtocol) {
        self.useCase = useCase
        bind()
    }
    
    @Published var folders: [FolderModel] = []
    
    @Published var isUpdateFolders: Bool = false
    @Published var isShowingAlert: Bool = false
    @Published var deleteFolderIndex: IndexSet?
    
    private func bind(){
        fetchFolders()
        observerIsUpdateFolders()
    }
    
    func fetchFolders(){
        Task{
            do{
                let fetchFolder = try await useCase.fetchFolders()
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
    
    func removeFolder(at offsets: IndexSet){
        Task{
            do{
                try await useCase.removeFolder(folder: folders[offsets.first!])
                await MainActor.run {
                    isUpdateFolders = true
                }
            }catch{
                print(error.localizedDescription)
            }
        }
    }
    
    func clearDeleteProperty(){
        isShowingAlert = false
        deleteFolderIndex = nil
    }
}
