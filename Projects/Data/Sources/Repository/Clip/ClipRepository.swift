//
//  ClipRepository.swift
//  Data
//
//  Created by 유현진 on 12/3/24.
//

import Foundation
import Domain
import FirebaseAuth
import FirebaseFirestore

final public class ClipRepository: ClipRepositoryProtocol{
    private let db: Firestore

    public init(db: Firestore = FirestoreManager.shared.db) {
        self.db = db
    }
}
extension ClipRepository{
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
        do{
            let newModel = URLClipModelDTO(model: model)
            let docRef = db.collection("URLs").document(model.id)
            try docRef.setData(from: newModel)
            return newModel.id
        }catch{
            throw error
        }
    }
    
    public func fetchURLs(urls: [String]) async throws -> [URLClipModel] {
        var models = [URLClipModel]()
        do{
            let docRef = db.collection("URLs")
            for url in urls {
                let model = try await docRef.document(url).getDocument(as: URLClipModelDTO.self).toEntity()
                models.append(model)
            }
            return models
        }catch{
            throw error
        }
    }
    
}
extension ClipRepository{
    // MARK: Folder
    public func makeFolder(newFolderName: String) async throws {
        do{
            let uid = Auth.auth().currentUser!.uid
            let newFolder = FolderModelDTO(title: newFolderName, URLs: [], uid: uid)
            let docRef = db.collection("users").document(uid).collection("folders").document(newFolder.id)
            try docRef.setData(from: newFolder)
        }catch{
            throw error
        }
    }
    
    public func fetchFolders() async throws -> [FolderModel]{
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
    
    public func fetchFolder(folderId: String) async throws -> FolderModel{
        do{
            let uid = Auth.auth().currentUser!.uid
            let docRef = db.collection("users").document(uid).collection("folders").document(folderId)
            let docuemnt = try await docRef.getDocument()
            let folder = try docuemnt.data(as: FolderModelDTO.self).toEntity()
            return folder
        }catch{
            throw error
        }
    }
    
    public func removeFolder(folder: FolderModel) async throws{
        do{
            let uid = Auth.auth().currentUser!.uid
            // 폴더 안에 있는 URL 삭제
            let urlDocRef = db.collection("URLs")
            for urlId in folder.URLs{
                try await urlDocRef.document(urlId).delete()
            }
            // 폴더 삭제
            let folderDocRef = db.collection("users").document(uid).collection("folders").document(folder.id)
            try await folderDocRef.delete()
        }catch{
            throw error
        }
    }
    
    public func editFolderTitle(folderId: String, editedTitle: String) async throws {
        do{
            let uid = Auth.auth().currentUser!.uid
            let docRef = db.collection("users").document(uid).collection("folders").document(folderId)
            try await docRef.updateData(["title" : editedTitle])
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
