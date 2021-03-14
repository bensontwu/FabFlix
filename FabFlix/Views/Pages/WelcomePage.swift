//
//  WelcomePage.swift
//  FabFlix
//
//  Created by Benson  on 3/13/21.
//

import SwiftUI

struct WelcomePage: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Fabflix")
                    .font(.title)
                
                Spacer()
                
                NavigationLink(destination: RegisterView()) {
                    RoundedButton(title: "Sign Up", foregroundColor: .white, backgroundColor: .black) {}
                }
                
                NavigationLink(destination: LoginView()) {
                    RoundedButton(title: "Login", foregroundColor: .white, backgroundColor: .yellow) {}
                }
                
                Spacer()
            }
            .padding()
        }
    }
}

struct WelcomePage_Previews: PreviewProvider {
    static var previews: some View {
        WelcomePage()
    }
}
