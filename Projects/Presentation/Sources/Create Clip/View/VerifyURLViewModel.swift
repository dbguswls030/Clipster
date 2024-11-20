//
//  VerifyURLViewModel.swift
//  Presentation
//
//  Created by 유현진 on 11/20/24.
//

import SwiftUI
import Combine
class VerifyURLViewModel: ObservableObject{
    @Published var url: String = ""
    @State private var cancellables = Set<AnyCancellable>()
    init(){
        bind()
    }
    
    private func bind(){
        $url
            .debounce(for: .seconds(1), scheduler: RunLoop.main)
            .flatMap { URLSession.shared.dataTaskPublisher(for: URL(string: $0)!) }
            .sink { completion in
                print("옳지 않은 URL")
            } receiveValue: { output in
                print(output.data)
            }
            .store(in: &cancellables)

                
            
    }
}
