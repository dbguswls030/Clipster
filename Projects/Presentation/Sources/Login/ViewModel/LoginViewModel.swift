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
    private let useCase: AuthUseCaseProtocol
    
    public init(useCase: AuthUseCaseProtocol){
        self.useCase = useCase
    }
    
    @Published var isSuccessedAppleLogin: Bool = false
    @Published var appleCredentialModel: AppleCredentialModel?
    @Published var isSuccessedFirebaseLogin: Bool = false
    
    func signInWithApple(){
        Task{
            do{
                let model = try await useCase.signInWithApple()
                await MainActor.run {
                    self.appleCredentialModel = model
                    self.isSuccessedAppleLogin = true
                }
            }catch{
                print(error.localizedDescription)
            }
        }
    }

    func signInWithFirebase(){
        guard let model = appleCredentialModel else { return }
        Task{
            do{
                let uid = try await useCase.signInWithFirebase(model: model)
                let isExist = try await useCase.checkIsExistedUser(uid: uid)
                if !isExist{ try await useCase.createUser(uid: uid)}
                await MainActor.run {
                    self.isSuccessedFirebaseLogin = true
                }
            }catch{
                print(error.localizedDescription)
            }
        }
    }
}
