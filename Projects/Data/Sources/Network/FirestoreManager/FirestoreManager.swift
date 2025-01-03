//
//  FirestoreManager.swift
//  Data
//
//  Created by 유현진 on 12/31/24.
//

import Foundation
import FirebaseFirestore

final public class FirestoreManager{
    public static let shared = FirestoreManager()
    public let db: Firestore
    
    private init() {
        db = Firestore.firestore()
    }
}
