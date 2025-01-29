//
//  URLDescriptionView.swift
//  Presentation
//
//  Created by 유현진 on 11/28/24.
//

import SwiftUI

struct URLDescriptionView: View {
    @Binding var description: String
    var focusTextEditor: FocusState<Bool>.Binding
    
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
                    .onChange(of: description) { desc in
                        if desc.count > 100 { // 제한할 글자수
                            DispatchQueue.main.async {
                                self.description = String(desc.prefix(100))
                            }
                        }
                    }
                    .focused(focusTextEditor)
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
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 15, trailing: 0))
                    .overlay(alignment: .bottomTrailing) {
                        Text("\(description.count)/100")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
            }
            .padding(.horizontal)
        }
    }
}

//#Preview {
//    URLDescriptionView(description: .constant(""))
//}
