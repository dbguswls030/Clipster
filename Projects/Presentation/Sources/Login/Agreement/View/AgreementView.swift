//
//  AgreementView.swift
//  Presentation
//
//  Created by 유현진 on 12/18/24.
//

import SwiftUI

public struct AgreementView: View {
    @ObservedObject var viewModel: LoginViewModel
    @ObservedObject var rootRouter: AppRouter
    
    public init(viewModel: LoginViewModel, router: AppRouter){
        self.viewModel = viewModel
        self.rootRouter = router
    }
    
    public var body: some View {
        VStack{
            Button {
                viewModel.signInWithFirebase()
            } label: {
                Text("동의하고 시작하기")
                    .foregroundStyle(.blue)
                    .font(.headline)
            }
            .frame(width: UIScreen.main.bounds.width * 0.8, height: 50)
            .background {
                RoundedRectangle(cornerRadius: 10, style: .continuous)
            }
            .padding(.top, 200)
        }
        .onChange(of: viewModel.isSuccessedFirebaseLogin) { newValue in
            if newValue{ rootRouter.currentRoute = .mainTab }
        }
    }
}

//#Preview {
//    AgreementView()
//}
