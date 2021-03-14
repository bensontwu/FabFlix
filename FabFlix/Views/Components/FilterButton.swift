//
//  FilterButton.swift
//  FabFlix
//
//  Created by Benson  on 3/14/21.
//

import SwiftUI

struct FilterButton: View {
    var title: String
    var action: () -> ()
    
    var body: some View {
        Button(action: {
            action()
        }) {
            Text(title)
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 1))
        }
    }
}

struct FilterButton_Previews: PreviewProvider {
    static var previews: some View {
        FilterButton(title: "Filter") {
            // do something
        }
    }
}
