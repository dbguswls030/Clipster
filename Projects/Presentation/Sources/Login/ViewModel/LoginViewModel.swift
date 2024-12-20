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
            .flatMap{ uid in
                return self.useCase.checkIsExistedUser(uid: uid)
                    .flatMap { isExisted -> AnyPublisher<Bool, Error> in
                        if isExisted {
                            // 사용자가 존재하면 true 반환
                            return Just(true)
                                .setFailureType(to: Error.self)
                                .eraseToAnyPublisher()
                        } else {
                            // 사용자가 존재하지 않으면 새 사용자 생성 후 false 반환
                            return self.useCase.createUser(uid: uid)
                                .map { _ in true }
                                .eraseToAnyPublisher()
                        }
                    }
            }
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("완료")
                case .failure(let error):
                    print("에러 발생: \(error)")
                }
            }, receiveValue: { isSuccess in
                print("결과: \(isSuccess ? "성공" : "실패")")
            })
            .store(in: &cancellables)
    }
}
