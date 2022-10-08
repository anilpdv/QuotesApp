//
//  ContentView.swift
//  QuotesApp
//
//  Created by anilpdv on 07/10/22.
//

import SwiftUI

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

struct ContentView: View {
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .foregroundColor: UIColor.white,
        ]
    }

    @State private var searchText = ""
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color(hex: "1c2321"), Color(hex: "1c2321")]), startPoint: .top, endPoint: .center)
                    .ignoresSafeArea()
                Color(hex: "EEF1EF").offset(y: 400)
                ScrollView {
                    HStack {
                        Image(systemName: "magnifyingglass")
                        Text("search quotes..")
                        Spacer()
                    }.font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.white)
                        .padding()
                        .background(Color(.init(white: 1, alpha: 0.4)))
                        .cornerRadius(13)
                        .padding(16)

                    DiscoverCategories()

                    VStack {
                        QuotesList().padding(.top)
                    }

                    .background(Color(hex: "EEF1EF"))
                }
            }.navigationTitle("Quotes")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
