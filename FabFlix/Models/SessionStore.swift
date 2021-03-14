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
    
    var sessionData: SessionData {
        SessionData(email: email, sessionId: sessionId)
    }
    
    public func reset() {
        email = ""
        sessionId = ""
    }
    
    public func setSession(email: String, sessionId: String) {
        self.email = email
        self.sessionId = sessionId
    }
}
