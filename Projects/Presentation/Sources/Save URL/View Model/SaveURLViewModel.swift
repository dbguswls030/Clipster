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
    
    @Published var metaData: URLMetaData?
    @Published var url: String = ""{
        didSet{
            isLoading = true
        }
    }
    private let useCase: SaveUseCaseProtocol
    
    public init(useCase: SaveUseCaseProtocol, clipBoradURL: String? = ""){
        self.useCase = useCase
        if let url = clipBoradURL{ self.url = url }
        bind()
    }
    
    public init(useCase: SaveUseCase){
        self.useCase = useCase
        bind()
    }
    
    @Published var isInvalidURL: Bool = false
    @Published var isLoading: Bool = false
    
    @Published var folderHierachy: [FolderModel] = []
    @Published var selectedFolder: String?
    @Published var expandedFolders: Set<String> = []
    @Published var description: String = ""
    
    private func bind(){
        $url
            .debounce(for: 1, scheduler: RunLoop.main)
            .map{URL(string: $0)}
            .removeDuplicates()
            .flatMap{ url in
                if let validURL = url{
                    return self.useCase.fetchMetaData(url: validURL)
                }else{
                    return Just(nil).eraseToAnyPublisher()
                }
            }
            .receive(on: RunLoop.main)
            .sink { [weak self] metaData in
                self?.isLoading = false
                self?.metaData = metaData
            }
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
        
//        $metaData
//            .sink { metaData in
//                print(metaData?.title)
//                print(metaData?.description)
//                print(metaData?.thumbnailImage)
//            }
//            .store(in: &cancellables)
        useCase.fetchFolder()
            .sink{ [weak self] fetchModel in
                self?.folderHierachy = fetchModel
            }
            .store(in: &cancellables)
    }
    
    func isAbleToSave() -> Bool{
        !isInvalidURL && selectedFolder != nil && !isLoading && !description.isEmpty && metaData != nil
    }
    
    func makeURLClipModel() {
        print(URLClipModel(folderId: selectedFolder!, URL: URL(string: url)!, description: description, metaData: metaData!))
    }
    
    func makeFolder(){
        useCase.makeFolder()
            .sink { _ in
                print("success makeFolder")
            }
            .store(in: &cancellables)
    }
}
