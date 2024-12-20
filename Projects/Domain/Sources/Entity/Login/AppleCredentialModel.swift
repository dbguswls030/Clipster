//
//  AppleCredentialModel.swift
//  Domain
//
//  Created by 유현진 on 12/18/24.
//

import Foundation

public struct AppleCredentialModel{
    public let idTokenString: String
    public let rawNonce: String
    public let fullName: PersonNameComponents
    
    public init(idTokenString: String, rawNonce: String, fullName: PersonNameComponents) {
        self.idTokenString = idTokenString
        self.rawNonce = rawNonce
        self.fullName = fullName
    }
}
