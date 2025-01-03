//
//  SaveRepository.swift
//  Data
//
//  Created by 유현진 on 12/3/24.
//

import Foundation
import Combine
import Domain
import FirebaseAuth
import FirebaseFirestore

enum SaveError: Error{
    case noUID
    case failedMakeFolder
    case notMoyaErrorType
    case failedFetchFolder
}

final public class SaveRepository: SaveRepositoryProtocol{
    private var cancellable = Set<AnyCancellable>()
    
    private let db: Firestore

    public init(db: Firestore = FirestoreManager.shared.db) {
        self.db = db
    }
}
extension SaveRepository{
    // MARK: URL
    public func fetchMetaData(url: URL) async throws -> URLMetaData?{
        do{
            let (data, _) = try await URLSession.shared.data(from: url)
            let html = String(data: data, encoding: .utf8) ?? ""
            return try? URLMetaDataResponseDTO.parseHTML(html)
        }catch{
            throw error
        }
    }

    public func makeURLClip(model: URLClipModel) async throws -> String{
        let uid = Auth.auth().currentUser!.uid
        let newModel = URLClipModelDTO(model: model)
        let docRef = db.collection("URLs").document(model.id)
        do{
            
            try docRef.setData(from: newModel)
            return newModel.id
        }catch{
            throw error
        }
    }
}
extension SaveRepository{
    // MARK: Folder
    public func makeFolder() async throws{
        do{
            let uid = Auth.auth().currentUser!.uid
            let newFolder = FolderModelDTO(title: "무제", subfolders: [], URLs: [], uid: uid)
            let docRef = db.collection("users").document(uid).collection("folders").document(newFolder.id)
            try docRef.setData(from: newFolder)
        }catch{
            throw error
        }
    }
    
    public func fetchFolder() async throws -> [FolderModel]{
        do{
            let uid = Auth.auth().currentUser!.uid
            let docRef = db.collection("users").document(uid).collection("folders")
            let querySnapshot = try await docRef.getDocuments()
            var folders = [FolderModel]()
            
            for document in querySnapshot.documents{
                let model = try document.data(as: FolderModelDTO.self).toEntity()
                folders.append(model)
            }
            return folders
        }catch{
            throw error
        }
    }
    
    public func saveURLClip(folderId: String, URLClipId: String) async throws{
        do{
            let uid = Auth.auth().currentUser!.uid
            let docRef = db.collection("users").document(uid).collection("folders").document(folderId)
            try await docRef.updateData([
                "URLs" : FirebaseFirestore.FieldValue.arrayUnion([URLClipId])
            ])
        }catch{
            throw error
        }
    }
}
