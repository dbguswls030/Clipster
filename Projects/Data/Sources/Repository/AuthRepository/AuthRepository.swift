//
//  AuthRepository.swift
//  Data
//
//  Created by 유현진 on 12/13/24.
//

import Foundation
import Combine
import Domain
import AuthenticationServices
import CryptoKit
import FirebaseAuth

enum SignInError: Error {
    case invalidToken
}

final public class AuthRepository: NSObject, AuthRepositoryProtocol{
    private var currentNonce: String?
    private var onCompletion: ((Result<String, Error>) -> Void)?
    
}

extension AuthRepository: ASAuthorizationControllerDelegate{
    public func testSignInWithApple() -> AnyPublisher<String, Error>{
        return Future{ [weak self] promise in
            
            let appleIDProvider = ASAuthorizationAppleIDProvider()
            let request = appleIDProvider.createRequest()
            let nonce = self?.randomNonceString()
            self?.currentNonce = nonce
            request.requestedScopes = [.fullName, .email] //유저로 부터 알 수 있는 정보들(name, email)
            
            let authorizationController = ASAuthorizationController(authorizationRequests: [request])
            authorizationController.delegate = self
            authorizationController.presentationContextProvider = self
            authorizationController.performRequests()
            
            self?.onCompletion = { result in
                promise(result)
            }
        }
        .eraseToAnyPublisher()
    }
    public func signInWithApple() -> Future<String, Error>{
        return Future{ [weak self] promise in
            
            let appleIDProvider = ASAuthorizationAppleIDProvider()
            let request = appleIDProvider.createRequest()
            let nonce = self?.randomNonceString()
            self?.currentNonce = nonce
            request.requestedScopes = [.fullName, .email] //유저로 부터 알 수 있는 정보들(name, email)
            
            let authorizationController = ASAuthorizationController(authorizationRequests: [request])
            authorizationController.delegate = self
            authorizationController.presentationContextProvider = self
            authorizationController.performRequests()
            
            self?.onCompletion = { result in
                promise(result)
            }
        }
    }
    
    public func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {

        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            guard let nonce = currentNonce else {
                fatalError("Invalid state: A login callback was received, but no login request was sent.")
            }
            guard let appleIDToken = appleIDCredential.identityToken else {
                print("Unable to fetch identity token")
                return
            }
            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                return
            }
            // Initialize a Firebase credential, including the user's full name.
            let credential = OAuthProvider.appleCredential(withIDToken: idTokenString,
                                                           rawNonce: nonce,
                                                           fullName: appleIDCredential.fullName)
            // Sign in with Firebase.
            Auth.auth().signIn(with: credential) { [weak self] (authResult, error) in
                guard let self = self else { return }
                if let error = error {
                    print(error.localizedDescription)
                    self.onCompletion?(.failure(SignInError.invalidToken))
                    return
                }
//                if let _ = authResult?.user.displayName { } // 처음 로그인 했을 때
                self.onCompletion?(.success((authResult?.user.uid)!))
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

extension AuthRepository: ASAuthorizationControllerPresentationContextProviding {
    public func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
            return scene.windows.first { $0.isKeyWindow } ?? UIWindow()
        }
        return UIWindow()
    }
}
