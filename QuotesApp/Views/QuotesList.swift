//
//  QuotesList.swift
//  QuotesApp
//
//  Created by anilpdv on 08/10/22.
//

import Kingfisher
import SwiftUI

struct Quotes: Decodable {
    var quotes: [QuoteObj]
}

struct QuoteObj: Decodable, Hashable {
    let author, img, quote: String
}

class QuotesListModel: ObservableObject {
    @Published var isLoading = true
    @Published var res: Quotes?

    init() {
        let urlString = "https://quotesappapi.herokuapp.com/quotes"

        guard let url = URL(string: urlString) else { return }

        DispatchQueue.main.async {
            URLSession.shared.dataTask(with: url) { data, _, _ in
                guard let data = data else { return }
                self.res = try? JSONDecoder().decode(Quotes.self, from: data)
            }.resume()
        }
    }

    func loadPage(pageId: Int) {
        let urlString = "https://quotesappapi.herokuapp.com/quotes?page=\(pageId)"

        guard let url = URL(string: urlString) else { return }

        DispatchQueue.main.async {
            URLSession.shared.dataTask(with: url) { data, _, _ in
                guard let data = data else { return }
                var quotesData = try? JSONDecoder().decode(Quotes.self, from: data)

                self.res?.quotes.append(contentsOf: quotesData?.quotes ?? [])

            }.resume()
        }
    }
}

struct QuotesList: View {
    @ObservedObject var vm = QuotesListModel()
    @State var currentIndex = 1
    var body: some View {
        ScrollView(.vertical) {
            ScrollViewReader { _ in

                ForEach(vm.res?.quotes ?? [], id: \.self) { quote in

                    QuoteTileView(quote: quote)
                }

                ScrollView(.horizontal) {
                    HStack {
                        ForEach(1 ..< 101, id: \.self) { num in
                            Button(action: {
                                self.vm.loadPage(pageId: num)
                                self.currentIndex = num

                            }) {
                                Text("\(num)")
                                    .frame(width: 35, height: 35)
                                    .background(currentIndex == num ? Color(hex: "1c2321") : Color(hex: "7d98a1"))
                                    .clipShape(Circle())
                                    .font(.custom("Avenir-Heavy", size: 20))
                                    .foregroundColor(Color(hex: "eef1ef"))
                                    .id(num)
                            }
                        }
                    }.padding().padding(.bottom)
                }
            }
        }
    }
}

struct QuotesList_Previews: PreviewProvider {
    static var previews: some View {
        QuotesList()
    }
}
