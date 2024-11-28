//
//  URLDescriptionView.swift
//  Presentation
//
//  Created by 유현진 on 11/28/24.
//

import SwiftUI

struct URLDescriptionView: View {
    @State var description: String = ""
    var body: some View {
        VStack(spacing: 15){
            HStack{
                Text("📝 메모")
                    .font(.title2)
                    .bold()
                    .foregroundStyle(.black)
                    .padding(.leading)
                Spacer()
            }
            GroupBox{
                TextField("간단한 메모를 작성해 주세요.", text: $description)
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    URLDescriptionView()
}
