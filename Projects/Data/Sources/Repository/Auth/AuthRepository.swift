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
import Moya
import CombineMoya
import FirebaseFirestore

enum AuthError: Error{
    case noUid
    case signInError
    case noApplefullName
    case isNotExistUser
    case failedCreateUser
}

final public class AuthRepository: NSObject{
    private var currentNonce: String?
    private var onCompletion: ((Result<AppleCredentialModel, Error>) -> Void)?
    private let service = MoyaProvider<AuthService>()
    private let db: Firestore

    public init(db: Firestore = FirestoreManager.shared.db) {
        self.db = db
    }
    
    private var cancellable = Set<AnyCancellable>()
    
}

extension AuthRepository: AuthRepositoryProtocol{
    public func checkIsExistedUser(uid: String) -> AnyPublisher<Bool, Error>{
        return service.requestPublisher(.checkIsExistedUser(uid: uid))
            .map { response in
                return response.statusCode == 200
            }
            .catch { _ in Just(false).setFailureType(to: Error.self) } // User does not exist
            .eraseToAnyPublisher()
    }
    
    public func createUser(uid: String) -> AnyPublisher<Void, Error>{
        let model = UserModelDTO(id: uid)
        return service.requestPublisher(.createUser(model: model))
            .tryMap{ response in
                guard response.statusCode == 200 else{
                    throw AuthError.failedCreateUser
                }
            }
            .catch{ error in
                Fail(error: error).eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
    public func signInWithFirebase(model: AppleCredentialModel) -> AnyPublisher<String, Error> {
        return Future{ promise in
            let credential = OAuthProvider.appleCredential(withIDToken: model.idTokenString,
                                                           rawNonce: model.rawNonce,
                                                           fullName: model.fullName)
            Auth.auth().signIn(with: credential) { (authResult, error) in
                if let error = error {
                    print(error.localizedDescription)
                    promise(.failure(AuthError.signInError))
                    return
                }
                guard let uid = authResult?.user.uid else {
                    promise(.failure(AuthError.noUid))
                    return
                }
                promise(.success(uid))
            }
        }
        .eraseToAnyPublisher()
    }
}

extension AuthRepository: ASAuthorizationControllerDelegate{
    public func signInWithApple() -> AnyPublisher<AppleCredentialModel, Error>{
        return Future{ [weak self] promise in
            guard let self = self else { return }
            let appleIDProvider = ASAuthorizationAppleIDProvider()
            let request = appleIDProvider.createRequest()
            let nonce = self.randomNonceString()
            self.currentNonce = nonce
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
            
            guard let fullName = appleIDCredential.fullName else{
                self.onCompletion?(.failure(AuthError.noApplefullName))
                return
            }
            
            self.onCompletion?(.success(AppleCredentialModel(idTokenString: idTokenString,
                                                                 rawNonce: nonce,
                                                                 fullName: fullName)))
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
