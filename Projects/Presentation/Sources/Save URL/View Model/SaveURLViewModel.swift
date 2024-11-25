//
//  SaveURLViewModel.swift
//  Presentation
//
//  Created by 유현진 on 11/25/24.
//

import SwiftUI
import Combine
import SwiftSoup

class SaveURLViewModel: ObservableObject{
    
    private var cancellables = Set<AnyCancellable>()
    
    @Published var url: String = ""{
        didSet{
            self.isLoading = true
        }
    }
    @Published var metaData: URLMetaData?
    @Published var isInvalidURL: Bool = false
    @Published var isLoading: Bool = false
    
    var URLStateSystemImage: String{
        isInvalidURL ? "exclamationmark.triangle.fill" : "checkmark.circle.fill"
    }
    var URLStateImageForegroundColor: Color{
        isInvalidURL ? .red : .green
    }
    
    init(clipBoardURL: String = ""){
        self.url = clipBoardURL
        bind()
    }
    
    private func bind(){
        $url
            .debounce(for: 1, scheduler: RunLoop.main)
            .map{URL(string: $0)}
            .removeDuplicates()
            .flatMap{ url in
                if let validURL = url{
                    return self.fetchMetaData(url: validURL)
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
        
        $metaData
            .sink { metaData in
                print(metaData?.title)
                print(metaData?.description)
                print(metaData?.thumbnailImage)
            }
            .store(in: &cancellables)
    }

    private func fetchMetaData(url: URL) -> AnyPublisher<URLMetaData?, Never>{
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap{ data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse,
                      200..<300 ~= httpResponse.statusCode else{
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .tryMap{ data -> URLMetaData? in
                let html = String(data: data, encoding: .utf8) ?? ""
                return try self.parseHTML(html)
            }
            .replaceError(with: nil)
            .eraseToAnyPublisher()
    }
    
    private func parseHTML(_ html: String) throws -> URLMetaData? {
        let document = try SwiftSoup.parse(html)
        
        // Open Graph 메타데이터 추출
        let title = try document.select("meta[property=og:title]").attr("content")
        let description = try document.select("meta[property=og:description]").attr("content")
        let imageURLString = try document.select("meta[property=og:image]").attr("content")
        
        // URL로 변환
        let imageURL = URL(string: imageURLString)
        
        return URLMetaData(title: title, description: description, thumbnailImage: imageURL)
    }
}


