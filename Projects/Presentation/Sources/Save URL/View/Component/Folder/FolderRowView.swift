//
//  FolderRowView.swift
//  Presentation
//
//  Created by 유현진 on 11/27/24.
//

import SwiftUI

struct FolderRowView: View {
    var folder: FolderModel
    @Binding var selectedFolderID: UUID?
    @Binding var expandedFolders: Set<UUID>
    
    var body: some View {
        HStack(alignment: .center){
            Text("- " + folder.title)
                .font(.headline)
                .fontWeight(.semibold)
                
            Spacer()
            
            if folder.subfolders != nil{
                Button{
                    withAnimation{
                        toggleFolder()
                    }
                } label: {
                    Image(systemName: expandedFolders.contains(folder.id) ? "chevron.down" : "chevron.right")
                }
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            selectedFolderID = folder.id
        }
        .padding(4)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .background(selectedFolderID == folder.id ? Color.secondary : Color.clear)
        if expandedFolders.contains(folder.id), let subfolders = folder.subfolders {
                        ForEach(subfolders) { subfolder in
                            FolderRowView(folder: subfolder, selectedFolderID: $selectedFolderID, expandedFolders: $expandedFolders)
                                .padding(.leading, 20) // 하위 폴더는 들여쓰기
                        }
                    }
    }
    private func toggleFolder() {
        if expandedFolders.contains(folder.id) {
            expandedFolders.remove(folder.id)
        } else {
            expandedFolders.insert(folder.id)
        }
    }
}

#Preview {
    FolderRowView(folder: FolderModel(title: "경제", subfolders: []), selectedFolderID: .constant(UUID()), expandedFolders: .constant([]))
}
