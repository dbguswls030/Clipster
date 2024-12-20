//
//  RootViewModel.swift
//  Presentation
//
//  Created by 유현진 on 12/15/24.
//

import Foundation
import Combine
import Domain

public class RootViewModel: ObservableObject{
    private var cancellables = Set<AnyCancellable>()
    let useCase: RootUseCaseProtocol
    
    public init(useCase: RootUseCaseProtocol) {
        self.useCase = useCase
        bind()
    }
    
    @Published var isLoggedIn: Bool = false
    
    private func bind(){
        useCase.authStateListener()
            .receive(on: DispatchQueue.main)
            .assign(to: \.isLoggedIn, on: self)
            .store(in: &cancellables)
    }
    
}
