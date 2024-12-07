//
//  FolderViewModel.swift
//  Presentation
//
//  Created by 유현진 on 11/28/24.
//

import SwiftUI
import Domain

class FolderViewModel: ObservableObject{
    @Binding var folderHierachy: [FolderModel]
    @Binding var selectedFolderId: String?
    @Binding var expandedFolders: Set<String>
    
    init(folderHierachy: Binding<[FolderModel]>, selection: Binding<String?>, expandedFolders: Binding<Set<String>>) {
        self._folderHierachy = folderHierachy
        self._selectedFolderId = selection
        self._expandedFolders = expandedFolders
    }
}
