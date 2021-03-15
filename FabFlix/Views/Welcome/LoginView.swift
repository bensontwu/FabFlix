//
//  LoginView.swift
//  FabFlix
//
//  Created by Benson  on 3/13/21.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var sessionStore: SessionStore
    @Binding var idmViewState: IdmViewState
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showingAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        VStack {
            Spacer()
            
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
            
            Spacer()
            
            RoundedButton(title: "Register", foregroundColor: .black,
                          backgroundColor: lightGreyColor, maxWidth: 100) {
                idmViewState = .register
            }
        }
        .padding()
        .alert(isPresented: $showingAlert) {
            Alert(title: Text(alertMessage), dismissButton: .default(Text("OK")))
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
    @State static var idmViewState: IdmViewState = .login
    
    static var previews: some View {
        LoginView(idmViewState: $idmViewState)
            .environmentObject(SessionStore())
    }
}
