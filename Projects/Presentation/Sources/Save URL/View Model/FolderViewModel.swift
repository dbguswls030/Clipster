//
//  FolderViewModel.swift
//  Presentation
//
//  Created by 유현진 on 11/28/24.
//

import SwiftUI

class FolderViewModel: ObservableObject{
    @Binding var folderHierachy: [FolderModel]
    @Binding var selection: UUID?
    @Binding var expandedFolders: Set<UUID>
    
    init(folderHierachy: Binding<[FolderModel]>, selection: Binding<UUID?>, expandedFolders: Binding<Set<UUID>>) {
        self._folderHierachy = folderHierachy
        self._selection = selection
        self._expandedFolders = expandedFolders
    }
}
