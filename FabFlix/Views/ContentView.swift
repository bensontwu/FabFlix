//
//  ContentView.swift
//  FabFlix
//
//  Created by Benson  on 3/13/21.
//

import SwiftUI

let lightGreyColor = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)

struct ContentView: View {
    @EnvironmentObject private var sessionStore: SessionStore
    
    var body: some View {
        if sessionStore.sessionId == "" {
            WelcomePage()
        } else {
            MovieList()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
