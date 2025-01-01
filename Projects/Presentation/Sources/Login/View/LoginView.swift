//
//  LoginView.swift
//  Presentation
//
//  Created by 유현진 on 12/13/24.
//

import SwiftUI
import AuthenticationServices
import CryptoKit

public struct LoginView: View {
    @StateObject public var viewModel: LoginViewModel
    @ObservedObject var rootRouter: AppRouter
    public init(viewModel: LoginViewModel, router: AppRouter){
        self._viewModel = StateObject(wrappedValue: viewModel)
        self.rootRouter = router
    }
    
    public var body: some View {
        NavigationStack{
            VStack{
                Button {
                    viewModel.signInWithApple()
                } label: {
                    HStack{
                        PresentationAsset.appleLogo.swiftUIImage
                            .resizable()
                            .frame(width: 24, height: 24)
                            .padding(.leading, 25)
                        Spacer()
                        Text("Apple로 시작하기")
                            .foregroundStyle(.white)
                            .padding(.trailing, 25)
                        Spacer()
                    }
                }
                .frame(width: UIScreen.main.bounds.width * 0.8, height: 50)
                .background {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                }
                .padding(.top, 200)
            }
            .navigationDestination(isPresented: $viewModel.isSuccessedAppleLogin) {
                AgreementView(viewModel: viewModel, router: rootRouter)
            }
        }
    }
}


//#Preview {
//    LoginView()
//}
