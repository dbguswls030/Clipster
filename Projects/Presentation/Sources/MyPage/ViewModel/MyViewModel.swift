//
//  MyViewModel.swift
//  Presentation
//
//  Created by 유현진 on 12/17/24.
//

import Foundation
import Combine
import Domain

public class MyViewModel: ObservableObject{
    private var cancellables = Set<AnyCancellable>()
    let useCase: MyUseCaseProtocol
    
    public init(useCase: MyUseCaseProtocol) {
        self.useCase = useCase
    }
    
    func signOut(){
        useCase.signOut()
            .sink { completion in
                switch completion{
                case .finished:
                    print("signOut")
                case .failure(let error):
                    print("failed : \(error)")
                }
            } receiveValue: { _ in
                
            }
            .store(in: &cancellables)

    }
}
