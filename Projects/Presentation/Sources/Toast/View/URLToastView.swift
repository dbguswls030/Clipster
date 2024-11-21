//
//  URLToastView.swift
//  Presentation
//
//  Created by 유현진 on 11/17/24.
//

import SwiftUI

struct URLToastView: View {
    var url: URL
    var cancelButtonAction: (() -> Void)
    var saveButonAction: (() -> Void)
    
    var body: some View {
        VStack{
            HStack{
                Spacer()
                Button{
                    cancelButtonAction()
                } label: {
                    Image(systemName: "xmark")
                }
            }.padding([.top, .trailing])
            
            HStack{
                Text(url, format: .url)
                    .lineLimit(1)
                    .truncationMode(.tail)
                Spacer()
                Button {
                    saveButonAction()
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
    URLToastView(url: URL(string: "https://growingsaja.tistory.com/811")!, cancelButtonAction: {}, saveButonAction: {})
}
