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
    let useCase: RootUseCaseProtocol
    
    public init(useCase: RootUseCaseProtocol) {
        self.useCase = useCase
        bind()
    }
    
    @Published var isLoggedIn: Bool = false
    
    private func bind(){
        fetchCurrentUser()
    }
    
    private func fetchCurrentUser(){
        Task{
            let isLoggedIn = await useCase.fetchCurrentUser()
            await MainActor.run {
                self.isLoggedIn = isLoggedIn
            }
        }
    }
}
