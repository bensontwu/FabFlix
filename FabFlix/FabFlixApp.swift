//
//  FabFlixApp.swift
//  FabFlix
//
//  Created by Benson  on 3/13/21.
//

import SwiftUI

@main
struct FabFlixApp: App {
    let sessionStore = SessionStore()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(sessionStore)
                .environmentObject(MovieStore(sessionStore: sessionStore))
        }
    }
}
