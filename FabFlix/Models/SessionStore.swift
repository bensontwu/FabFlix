//
//  SessionData.swift
//  FabFlix
//
//  Created by Benson  on 3/13/21.
//

import Foundation

final class SessionStore: ObservableObject {
    
    @Published var email: String = ""
    @Published var sessionId: String = ""
    
    final let idmClient = IdmClient()
    
    var sessionData: SessionData {
        SessionData(email: email, sessionId: sessionId)
    }
    
    public func reset() {
        email = ""
        sessionId = ""
    }
    
    public func login(email: String, password: String, handler: @escaping (IdmResult, String?) -> ()) {
        idmClient.login(email: email, password: password) { [weak self] idmResult, message, sessionId in
            guard let self = self else { return }
            
            if let sessionId = sessionId {
                self.setSession(email: email, sessionId: sessionId)
                handler(.success, message)
            } else {
                handler(.failure, message)
            }
        }
    }
    
    public func register(email: String, password: String, handler: @escaping (IdmResult, String?) -> ()) {
        idmClient.register(email: email, password: password) { idmResult, message in
            handler(idmResult, message)
        }
    }
    
    private func setSession(email: String, sessionId: String) {
        self.email = email
        self.sessionId = sessionId
    }
}
