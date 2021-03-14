//
//  RegisterView.swift
//  FabFlix
//
//  Created by Benson  on 3/13/21.
//

import SwiftUI

struct RegisterView: View {
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
            
            RoundedButton(title: "Sign Up", foregroundColor: .white, backgroundColor: .black) {
                register()
            }
        }.padding()
    }
    
    private func register() {
        // push to login view
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
