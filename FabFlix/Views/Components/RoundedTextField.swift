//
//  TextField.swift
//  FabFlix
//
//  Created by Benson  on 3/14/21.
//

import SwiftUI

struct RoundedTextField: View {
    
    var placeholderText: String
    var autoCapitalizaition: UITextAutocapitalizationType = .words
    @Binding var textBinding: String
    
    var body: some View {
        TextField(placeholderText, text: $textBinding)
            .padding()
            .autocapitalization(autoCapitalizaition)
            .background(lightGreyColor)
            .cornerRadius(5.0)
    }
}

struct TextField_Previews: PreviewProvider {
    @State static var text: String = ""
    
    static var previews: some View {
        RoundedTextField(placeholderText: "Email", autoCapitalizaition: .none, textBinding: $text)
    }
}
