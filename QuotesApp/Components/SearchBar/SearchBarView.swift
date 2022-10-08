//
//  SearchBarView.swift
//  QuotesApp
//
//  Created by anilpdv on 07/10/22.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String

    var onCommit: () -> Void = { print("onCommit") }

    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")

                // Search text field
                ZStack(alignment: .leading) {
                    if searchText.isEmpty { // Separate text for placeholder to give it the proper color
                        Text("Search")
                    }
                    TextField("", text: $searchText, onEditingChanged: { _ in

                    }, onCommit: onCommit).foregroundColor(.primary)
                }
                // Clear button
                Button(action: {
                    self.searchText = ""
                }) {
                    Image(systemName: "xmark.circle.fill").opacity(searchText == "" ? 0 : 1)
                }
            }
            .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
            .foregroundColor(.secondary) // For magnifying glass and placeholder test
            .background(Color(.tertiarySystemFill))
            .cornerRadius(10.0)
        }
        .padding(.horizontal)
    }
}

struct SearchBarView_Previews: PreviewProvider {
    @State static var searchText = ""
    static var previews: some View {
        SearchBarView(searchText: $searchText)
    }
}
