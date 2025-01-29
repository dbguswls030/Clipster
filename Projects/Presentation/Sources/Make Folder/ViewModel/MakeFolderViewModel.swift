//
//  MakeFolderViewModel.swift
//  Presentation
//
//  Created by 유현진 on 1/14/25.
//

import Foundation
import Combine
import Domain

final public class MakeFolderViewModel: ObservableObject{
    let useCase: ClipUseCaseProtocol
    
    public init(useCase: ClipUseCaseProtocol) {
        self.useCase = useCase
    }
    
    @Published var folderName: String = ""
    @Published var isSuccess: Bool = false
    
    func makeFolder(newFolderName: String){
        Task{
            do{
                try await useCase.makeFolder(newFolderName: newFolderName)
                await MainActor.run {
                    isSuccess = true
                }
            }catch{
                print(error.localizedDescription)
            }
        }
    }
}
