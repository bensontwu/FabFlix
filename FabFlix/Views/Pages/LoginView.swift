//
//  LoginView.swift
//  FabFlix
//
//  Created by Benson  on 3/13/21.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var sessionStore: SessionStore
    @State var email: String = ""
    @State var password: String = ""
    
    var body: some View {
        VStack {
            Text("Fabflix")
                .font(.title)
            
            TextField("Email", text: $email)
                .padding()
                .background(lightGreyColor)
                .cornerRadius(5.0)
            SecureField("Password", text: $password)
                .padding()
                .background(lightGreyColor)
                .cornerRadius(5.0)
            
            RoundedButton(title: "Login", foregroundColor: .white, backgroundColor: .yellow) {
                login()
            }
        }.padding()
    }
    
    private func login() {
        sessionStore.setSession(email: email, sessionId: "asdadfasf")
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(SessionStore())
    }
}
