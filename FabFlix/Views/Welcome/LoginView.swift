//
//  LoginView.swift
//  FabFlix
//
//  Created by Benson  on 3/13/21.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var sessionStore: SessionStore
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showingAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        VStack {
            Text("Fabflix")
                .font(.title)
            
            RoundedTextField(placeholderText: "Email", autoCapitalizaition: .none, textBinding: $email)
            
            SecureField("Password", text: $password)
                .padding()
                .background(lightGreyColor)
                .cornerRadius(5.0)
            
            RoundedButton(title: "Login", foregroundColor: .white, backgroundColor: .yellow) {
                login()
            }
        }
        .padding()
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Login failed"), message: Text(alertMessage), dismissButton: .default(Text("Try again")))
        }
    }
    
    private func login() {
        sessionStore.login(email: email, password: password) { idmResult, message in
            if let message = message {
                alertMessage = message
            }
            showingAlert = true
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(SessionStore())
    }
}
