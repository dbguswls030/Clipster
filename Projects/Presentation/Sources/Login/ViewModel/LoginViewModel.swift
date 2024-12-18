//
//  LoginViewModel.swift
//  Presentation
//
//  Created by 유현진 on 12/13/24.
//

import Foundation
import Domain
import Combine

final public class LoginViewModel: ObservableObject{
    private var cancellables = Set<AnyCancellable>()
    
    private let useCase: AuthUseCaseProtocol
    
    public init(useCase: AuthUseCaseProtocol){
        self.useCase = useCase
    }
    
    func signInWithApple(){
        useCase.signInWithApple()
            .sink(receiveCompletion: { completion in
                switch completion{
                case .failure(let error):
                    print(error.localizedDescription)
                case .finished:
                    break
                }
            }, receiveValue: { result in
                print(result)
            })
            .store(in: &cancellables)
    }
}
