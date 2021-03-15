//
//  SearchPanel.swift
//  FabFlix
//
//  Created by Benson  on 3/14/21.
//

import SwiftUI

struct SearchPanel: View {
    
    @Binding var title: String
    @Binding var director: String
    @Binding var genre: String
    @Binding var year: String
    @Binding var orderBy: OrderBy
    @Binding var direction: Direction
    var onSubmit: () -> ()
    
    var body : some View {
        
        VStack(spacing: 15){
            
            RoundedTextField(placeholderText: "Title", textBinding: $title)
            
            RoundedTextField(placeholderText: "Director", textBinding: $director)
            
            RoundedTextField(placeholderText: "Genre", textBinding: $genre)
            
            RoundedTextField(placeholderText: "Year", textBinding: $year)
            
            Picker("Sort By", selection: $orderBy) {
                ForEach(OrderBy.allCases) { orderBy in
                    Text(orderBy.rawValue.capitalized).tag(orderBy)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            
            Picker("Sort Direction", selection: $direction) {
                ForEach(Direction.allCases) { direction in
                    Text(direction.rawValue.capitalized).tag(direction)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            
            RoundedButton(title: "Submit", foregroundColor: .white, backgroundColor: .blue) {
                onSubmit()
            }
            
        }
        .padding(.bottom, (UIApplication.shared.windows.last?.safeAreaInsets.bottom)! + 10)
        .padding(.horizontal)
        .padding(.top, 20)
        .background(Color(UIColor.systemBackground))
        .cornerRadius(25)
        
    }
}

struct SearchPanel_Previews: PreviewProvider {
    
    @State static var title: String = ""
    @State static var director: String = ""
    @State static var genre: String = ""
    @State static var year: String = ""
    @State static var orderBy: OrderBy = OrderBy.title
    @State static var direction: Direction = Direction.asc
    static var onSubmit: () -> () = { print("Submit!") }
    
    static var previews: some View {
        SearchPanel(title: $title, director: $director, genre: $genre, year: $year, orderBy: $orderBy, direction: $direction) {
            onSubmit()
        }
    }
}
