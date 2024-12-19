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
    
    @Published var isSuccessedAppleLogin: Bool = false
    @Published var appleCredentialModel: AppleCredentialModel?
    
    func signInWithApple(){
        useCase.signInWithApple()
            .sink { completion in
                switch completion{
                case .failure(let error):
                    print(error.localizedDescription)
                case .finished:
                    break
                }
            } receiveValue: { [weak self] model in
                self?.appleCredentialModel = model
                self?.isSuccessedAppleLogin = true
            }
            .store(in: &cancellables)
    }
    
    func signInWithFirebase(){
        guard let model = appleCredentialModel else { return }
        useCase.signInWithFirebase(model: model)
            .sink { completion in
                switch completion{
                case .failure(let error):
                    print(error.localizedDescription)
                case .finished:
                    break
                }
            } receiveValue: { value in
                print(value)
            }
            .store(in: &cancellables)

            
    }
}
