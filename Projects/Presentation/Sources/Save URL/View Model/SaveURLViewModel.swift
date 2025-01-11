//
//  SaveURLViewModel.swift
//  Presentation
//
//  Created by 유현진 on 11/25/24.
//

import SwiftUI
import Combine
import SwiftSoup
import Domain


final public class SaveURLViewModel: ObservableObject{
    
    private var cancellables = Set<AnyCancellable>()
    private let useCase: ClipUseCaseProtocol
    
    public init(useCase: ClipUseCaseProtocol, clipBoradURL: String? = ""){
        self.useCase = useCase
        if let url = clipBoradURL{ self.url = url }
        bind()
    }
    
    public init(useCase: ClipUseCaseProtocol){
        self.useCase = useCase
        bind()
    }
    
    @Published var metaData: URLMetaData?
    @Published var url: String = ""{
        didSet{
            isLoadingForTextField = true
        }
    }
    
    @Published var isInvalidURL: Bool = false
    @Published var isLoadingForTextField: Bool = false
    
    @Published var folderHierachy: [FolderModel] = []
    @Published var selectedFolder: String?
    @Published var expandedFolders: Set<String> = []
    @Published var description: String = ""
    
    @Published var isSaved: Bool = false
    @Published var isLoadingDuringSave: Bool = false
    @Published var isLoadingDuringMakeFolder: Bool = false
    
    private func bind(){
        $url
            .debounce(for: 1, scheduler: RunLoop.main)
            .map{URL(string: $0)}
            .removeDuplicates()
            .sink(receiveValue: { [weak self] url in
                if let validURL = url {
                    self?.fetchURLMetaData(url: validURL)
                }
            })
            .store(in: &cancellables)
        
        $metaData
            .map{ $0 == nil }
            .sink{ [weak self] isInvalidMetaData in
                if isInvalidMetaData{
                    self?.isInvalidURL = true
                }else{
                    self?.isInvalidURL = false
                }
            }.store(in: &cancellables)
        
        fetchFolders()
    }
    
    private func fetchURLMetaData(url: URL){
        Task{
            do{
                let metaData = try await useCase.fetchMetaData(url: url)
                await MainActor.run {
                    self.metaData = metaData
                    self.isLoadingForTextField = false
                }
            }catch{
                print(error.localizedDescription)
            }
        }
    }
    
    func isAbleToSave() -> Bool{
        !isInvalidURL && selectedFolder != nil && !isLoadingForTextField && !description.isEmpty && metaData != nil && !isLoadingDuringSave
    }
    
    func makeURLClipModel() {
        isLoadingDuringSave = true
        Task{
            do{
                let newModel = URLClipModel(uid: UUID().uuidString, folderId: selectedFolder!, URL: URL(string: url)!, description: description, metaData: metaData!)
                let URLClipId = try await useCase.makeURLClip(model: newModel)
                try await useCase.saveURLClip(folderId: selectedFolder!, URLClipId: URLClipId)
                
                await MainActor.run {
                    self.isLoadingDuringSave = false
                    self.isSaved = true
                }
            }catch{
                print(error.localizedDescription)
                await MainActor.run {
                    self.isLoadingDuringSave = false
                }
            }
        }
    }
    
    func fetchFolders(){
        Task{
            do{
                let folders = try await useCase.fetchFolder()
                await MainActor.run {
                    self.folderHierachy = folders
                }
            }catch{
                print(error.localizedDescription)
            }
        }
    }
    
    func makeFolder(){
        self.isLoadingDuringMakeFolder = true
        Task{
            do{
                try await useCase.makeFolder()
                let folders = try await useCase.fetchFolder()
                await MainActor.run {
                    self.isLoadingDuringMakeFolder = false
                    self.folderHierachy = folders
                }
            }catch{
                await MainActor.run {
                    self.isLoadingDuringMakeFolder = false
                }
            }
        }
    }
}
