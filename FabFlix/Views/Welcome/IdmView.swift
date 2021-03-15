//
//  IdmView.swift
//  FabFlix
//
//  Created by Benson  on 3/14/21.
//

import SwiftUI

enum IdmViewState {
    case login
    case register
}

struct IdmView: View {
    
    @Binding var idmViewState: IdmViewState
    
    var body: some View {
        switch idmViewState {
        case .login:
            LoginView(idmViewState: $idmViewState)
        case .register:
            RegisterView(idmViewState: $idmViewState)
        }
    }
}

struct IdmView_Previews: PreviewProvider {
    @State static var idmViewState1: IdmViewState = .login
    @State static var idmViewState2: IdmViewState = .register
    
    static var previews: some View {
        IdmView(idmViewState: $idmViewState1)
        IdmView(idmViewState: $idmViewState2)
    }
}
