//
//  RoundedButton.swift
//  FabFlix
//
//  Created by Benson  on 3/13/21.
//

import SwiftUI

struct RoundedButton: View {
    var title: String
    var foregroundColor: Color
    var backgroundColor: Color
    var maxWidth: CGFloat = .infinity
    var action: () -> ()
    
    var body: some View {
        Button(title) {
            action()
        }
        .padding(.vertical, 10)
        .frame(minWidth: 0, maxWidth: maxWidth)
        .font(.title3)
        .background(backgroundColor)
        .foregroundColor(foregroundColor)
        .cornerRadius(15.0)
    }
}

struct RoundedButton_Previews: PreviewProvider {
    static var previews: some View {
        RoundedButton(title: "Login", foregroundColor: .white, backgroundColor: .yellow, action: {
            print("Login!")
        })
        .previewLayout(.fixed(width: 300, height: 100))
    }
}
