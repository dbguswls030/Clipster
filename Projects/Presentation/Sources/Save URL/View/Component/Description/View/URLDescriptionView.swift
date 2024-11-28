//
//  URLDescriptionView.swift
//  Presentation
//
//  Created by 유현진 on 11/28/24.
//

import SwiftUI

struct URLDescriptionView: View {
    @Binding var description: String
    
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
                TextEditor(text: $description)
                    .overlay(alignment: .topLeading){
                        Text("간단한 메모를 작성해 주세요.")
                            .foregroundStyle(description.isEmpty ? .gray : .clear)
                            .fontWeight(.medium)
                            .padding([.top, .leading], 8)
                    }
                    .frame(height: 100)
                    .scrollContentBackground(.hidden)
                    .background(Color(.systemGray6))
                    .fontWeight(.medium)
                
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    URLDescriptionView(description: .constant(""))
}
