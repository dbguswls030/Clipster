//
//  ClipRow.swift
//  Presentation
//
//  Created by 유현진 on 1/7/25.
//

import SwiftUI
import Domain

struct ClipRow: View {
    @Binding var metaData: URLMetaData?
    
    var body: some View {
        HStack{
            // TODO: 기본 이미지...
            PreViewURLView(metaData: $metaData)
        }
        .contentShape(Rectangle())
        .padding(4)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

#Preview {
    ClipRow(metaData: .constant(URLMetaData.sampleData))
}
