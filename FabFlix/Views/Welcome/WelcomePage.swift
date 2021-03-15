//
//  WelcomePage.swift
//  FabFlix
//
//  Created by Benson  on 3/13/21.
//

import SwiftUI

struct WelcomePage: View {
    
    @State private var idmViewState: IdmViewState = .login
    @State private var action: Int?
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Fabflix")
                    .font(.title)
                
                Spacer()
                
                NavigationLink(destination: IdmView(idmViewState: $idmViewState), tag: 1, selection: $action) {
                }
                
                RoundedButton(title: "Sign Up", foregroundColor: .white, backgroundColor: .black) {
                    idmViewState = .register
                    action = 1
                }
                
                RoundedButton(title: "Login", foregroundColor: .white, backgroundColor: .yellow) {
                    idmViewState = .login
                    action = 1
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
