//
//  RegisterView.swift
//  FabFlix
//
//  Created by Benson  on 3/13/21.
//

import SwiftUI

struct RegisterView: View {
    @EnvironmentObject var sessionStore: SessionStore
    @State var email: String = ""
    @State var password: String = ""
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
            Alert(title: Text("Register failed"), message: Text(alertMessage), dismissButton: .default(Text("Try again")))
        }
    }
    
    private func register() {
        sessionStore.register(email: email, password: password) { idmResult, message in
            if let message = message {
                alertMessage = message
            }
            showingAlert = true
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
