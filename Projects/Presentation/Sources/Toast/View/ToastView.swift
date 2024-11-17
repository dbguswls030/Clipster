//
//  ToastView.swift
//  Presentation
//
//  Created by 유현진 on 11/17/24.
//

import SwiftUI

struct ToastView: View {
//    @Binding var toastModel: ToastModel
    var url: URL
    var body: some View {
        VStack{
            HStack{
                Spacer()
                Button{
                    
                } label: {
                    Image(systemName: "xmark")
                }
            }.padding([.top, .trailing])
            
            HStack{
                Text(url, format: .url)
                // TODO: 텍스트가 길어지면?
                Spacer()
                Button {
                    
                } label: {
                    Text("저장")
                }
            }
            .padding()
        }
        .frame(maxWidth: .infinity)
        .foregroundStyle(.black)
        .background(.purple)
        .cornerRadius(12)
    }
}

#Preview {
    ToastView(url: URL(string: "https://growingsaja.tistory.com/811")!)
}
