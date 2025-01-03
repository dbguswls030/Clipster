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
    let useCase: MyUseCaseProtocol
    
    public init(useCase: MyUseCaseProtocol) {
        self.useCase = useCase
    }
    
    @Published var isExited: Bool = false
    
    func logout(){
        Task{
            do{
                try await useCase.logout()
                await MainActor.run {
                    self.isExited = true
                }
            }catch{
                print(error.localizedDescription)
            }
        }
    }
    
    func signout(){
        Task{
            do{
                try await useCase.signout()
                try await useCase.logout()
                await MainActor.run {
                    self.isExited = true
                }
            }catch{
                print(error.localizedDescription)
            }
        }
    }
}
