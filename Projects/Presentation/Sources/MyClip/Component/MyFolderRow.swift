//
//  MyFolderRow.swift
//  Presentation
//
//  Created by 유현진 on 1/5/25.
//

import SwiftUI
import Domain

struct MyFolderRow: View {
    var folder: FolderModel
    
    var body: some View {
        HStack(alignment: .center){
            Text("-")
                .font(.headline)
                .fontWeight(.semibold)
            
            Text(folder.title)
                .font(.headline)
                .fontWeight(.semibold)
            
            Spacer()
        }
        .contentShape(Rectangle())
        .padding(4)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

//#Preview {
//    MyFolderRow()
//}
