//
//  MyClipViewModel.swift
//  Presentation
//
//  Created by 유현진 on 1/5/25.
//

import Foundation
import Domain

final public class MyClipViewModel: ObservableObject{
    let useCase: SaveUseCaseProtocol
    
    public init(useCase: SaveUseCaseProtocol) {
        self.useCase = useCase
        bind()
    }
    
    @Published var folders: [FolderModel] = []
    
    private func bind(){
        fetchFolders()
    }
    
    private func fetchFolders(){
        Task{
            do{
                let fetchFolder = try await useCase.fetchFolder()
                await MainActor.run {
                    folders = fetchFolder
                }
            }catch{
                print(error.localizedDescription)
            }
        }
    }
}
