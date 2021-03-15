//
//  RegisterView.swift
//  FabFlix
//
//  Created by Benson  on 3/13/21.
//

import SwiftUI

struct RegisterView: View {
    @EnvironmentObject var sessionStore: SessionStore
    @Binding var idmViewState: IdmViewState
    @State var email: String = ""
    @State var password: String = ""
    @State private var idmResult: IdmResult = .failure
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
            
            RoundedButton(title: "Sign Up", foregroundColor: .white, backgroundColor: .black) {
                register()
            }
        }
        .padding()
        .alert(isPresented: $showingAlert) {
            Alert(title: Text(alertMessage), dismissButton: .default(Text("OK")) {
                switch idmResult {
                case .failure:
                    return
                case .success:
                    idmViewState = .login
                }
            })
        }
    }
    
    private func register() {
        sessionStore.register(email: email, password: password) { idmResult, message in
            if let message = message {
                alertMessage = message
            }
            self.idmResult = idmResult
            showingAlert = true
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    @State static var idmViewState: IdmViewState = .register
    
    static var previews: some View {
        RegisterView(idmViewState: $idmViewState)
            .environmentObject(SessionStore())
    }
}
