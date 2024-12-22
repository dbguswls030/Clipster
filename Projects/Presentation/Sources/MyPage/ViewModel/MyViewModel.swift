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
    
    @Published var isExited: Bool = false
    
    func logout(){
        useCase.logout()
            .sink { completion in
                switch completion{
                case .finished:
                    print("logout")
                case .failure(let error):
                    print("failed : \(error)")
                }
            } receiveValue: { [weak self] _ in
                self?.isExited = true
            }
            .store(in: &cancellables)
    }
    
    func signout(){
        useCase.signout()
            .tryMap{ [weak self] in
                return self?.useCase.logout()
            }
            .sink { completion in
                switch completion{
                case .finished:
                    print("signout & logout")
                case .failure(let error):
                    print("failed : \(error)")
                }
            } receiveValue: { [weak self] _ in
                self?.isExited = true
            }
            .store(in: &cancellables)
    }
}
