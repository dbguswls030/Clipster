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

enum MyError: Error{
    case logoutError
    case signoutError
}
final public class MyRepository: NSObject, MyRepositoryProtocol{
    
    private var currentNonce: String?
    private var onCompletion: ((Result<Void, Error>) -> Void)?
    
    public func logout() -> AnyPublisher<Void, Error>{
        return Future{ promise in
            let firebaseAuth = Auth.auth()
            do {
                try firebaseAuth.signOut()
                promise(.success(()))
            } catch let signOutError as NSError {
                print("Error signing out: %@", signOutError)
                promise(.failure(MyError.logoutError))
            }
        }
        .eraseToAnyPublisher()
    }
}

extension MyRepository: ASAuthorizationControllerDelegate{
    public func signout() -> AnyPublisher<Void, Error> {
        return Future{ [weak self] promise in
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
                promise(result)
            }
        }
        .eraseToAnyPublisher()
    }
    
    public func authorizationController(controller: ASAuthorizationController,
                                 didCompleteWithAuthorization authorization: ASAuthorization) {
        guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential
        else {
            print("Unable to retrieve AppleIDCredential")
            return
        }
        
        guard let _ = currentNonce else {
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
