//
//  ContentView.swift
//  QuotesApp
//
//  Created by anilpdv on 07/10/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var quotesModel = QuotesListModel()
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .foregroundColor: UIColor.white,
        ]
    }

    @State private var searchText = ""
    fileprivate func getViews() -> some View {
        return ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(hex: "1c2321"), Color(hex: "1c2321")]), startPoint: .top, endPoint: .center)
                .ignoresSafeArea()
            Color(hex: "EEF1EF").offset(y: 300)
            ScrollView {
                VStack {
                    SearchBarView(searchText: $searchText)
                    DiscoverCategories().padding(.bottom)
                }.frame(width: 390, height: 170)
                
                VStack {
                    QuotesList().padding(.top)
                }
                
                .background(Color(hex: "EEF1EF"))
            }
        }.navigationTitle("Quotes").environmentObject(quotesModel)
    }
    
    var body: some View {
        NavigationView {
            getViews()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
