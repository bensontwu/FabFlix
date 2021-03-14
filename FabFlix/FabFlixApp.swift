//
//  FabFlixApp.swift
//  FabFlix
//
//  Created by Benson  on 3/13/21.
//

import SwiftUI

@main
struct FabFlixApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(SessionStore())
        }
    }
}
