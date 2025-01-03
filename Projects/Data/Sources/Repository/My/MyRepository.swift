//
//  MyRepository.swift
//  Data
//
//  Created by 유현진 on 12/17/24.
//

import Foundation
import Combine
import Domain
import FirebaseAuth
import AuthenticationServices
import CryptoKit
import FirebaseFirestore

enum MyError: Error{
    case logoutError
    case signoutError
    case reauthenticateError
}

final public class MyRepository: NSObject, MyRepositoryProtocol{
    
    private var currentNonce: String?
    private var onCompletion: ((Result<Void, Error>) -> Void)?
    
    private let db: Firestore

    public init(db: Firestore = FirestoreManager.shared.db) {
        self.db = db
    }
    
    public func logout() async throws {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch {
            throw error
        }
    }
}

extension MyRepository: ASAuthorizationControllerDelegate{
    public func signout() async throws {
        return try await Future<Void, Error> { [weak self] promise in
            guard let self = self else { return }
            let nonce = self.randomNonceString()
            self.currentNonce = nonce
            let appleIDProvider = ASAuthorizationAppleIDProvider()
            let request = appleIDProvider.createRequest()
            
            request.requestedScopes = [.fullName, .email] //유저로 부터 알 수 있는 정보들(name, email)
            request.nonce = sha256(nonce)
            let authorizationController = ASAuthorizationController(authorizationRequests: [request])
            authorizationController.delegate = self
            authorizationController.presentationContextProvider = self
            authorizationController.performRequests()
            
            self.onCompletion = { result in
                switch result{
                case .success:
                    promise(.success(()))
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }
        .value
    }
    
    public func authorizationController(controller: ASAuthorizationController,
                                 didCompleteWithAuthorization authorization: ASAuthorization) {
        guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential
        else {
            print("Unable to retrieve AppleIDCredential")
            return
        }
        
        guard let nonce = currentNonce else {
            fatalError("Invalid state: A login callback was received, but no login request was sent.")
        }
        
        guard let appleAuthCode = appleIDCredential.authorizationCode else {
            print("Unable to fetch authorization code")
            return
        }
        
        guard let authCodeString = String(data: appleAuthCode, encoding: .utf8) else {
            print("Unable to serialize auth code string from data: \(appleAuthCode.debugDescription)")
            return
        }
        
        guard let appleIDToken = appleIDCredential.identityToken else {
            print("Unable to fetch identity token")
            return
        }
        guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
            print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
            return
        }
        
        
        let credential = OAuthProvider.appleCredential(withIDToken: idTokenString,
                                                                rawNonce: nonce,
                                                                fullName: appleIDCredential.fullName)
        
        Auth.auth().currentUser?.reauthenticate(with: credential){ (authResult, error) in
            if let error = error {
                self.onCompletion?(.failure(error))
                return
            }
            Auth.auth().revokeToken(withAuthorizationCode: authCodeString){ error in
                if let error = error {
                    self.onCompletion?(.failure(error))
                    return
                }
                let user = Auth.auth().currentUser
                user?.delete { error in
                  if let error = error {
                      self.onCompletion?(.failure(error))
                  } else {
                      self.onCompletion?(.success(()))
                  }
                }
            }
        }
    }
    
    public func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        onCompletion?(.failure(error))
    }
    
    private func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            String(format: "%02x", $0)
        }.joined()
        
        return hashString
    }
    
    private func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        var randomBytes = [UInt8](repeating: 0, count: length)
        let errorCode = SecRandomCopyBytes(kSecRandomDefault, randomBytes.count, &randomBytes)
        if errorCode != errSecSuccess {
            fatalError(
                "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
            )
        }
        
        let charset: [Character] =
        Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        
        let nonce = randomBytes.map { byte in
            // Pick a random character from the set, wrapping around if needed.
            charset[Int(byte) % charset.count]
        }
        
        return String(nonce)
    }
    
}

extension MyRepository: ASAuthorizationControllerPresentationContextProviding {
    public func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
            return scene.windows.first { $0.isKeyWindow } ?? UIWindow()
        }
        return UIWindow()
    }
}
