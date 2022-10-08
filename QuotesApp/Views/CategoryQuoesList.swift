//
//  CategoryQuoesList.swift
//  QuotesApp
//
//  Created by anilpdv on 08/10/22.
//

import SwiftUI

class CategoryQuotesListModel: ObservableObject {
    @Published var isLoading = true
    @Published var res: Quotes?

    init(categoryName: String) {
        let urlString = "https://quotesappapi.herokuapp.com/tag/\(categoryName.lowercased())"

        guard let url = URL(string: urlString) else { return }

        DispatchQueue.main.async {
            URLSession.shared.dataTask(with: url) { data, _, _ in
                guard let data = data else { return }
                self.res = try? JSONDecoder().decode(Quotes.self, from: data)
            }.resume()
        }
    }
}

struct CategoryQuotesList: View {
    let category: Category

    @ObservedObject var vm: CategoryQuotesListModel

    init(category: Category) {
        self.category = category
        vm = .init(categoryName: category.name)
    }

    var body: some View {
        ScrollView {
            Text(category.name).font(.custom("Avenir-Heavy", size: 24))
            ForEach(vm.res?.quotes ?? [], id: \.self) { quote in

                QuoteTileView(quote: quote)
            }
        }.navigationBarTitle(category.name)
    }
}

struct CategoryQuotesList_Previews: PreviewProvider {
    static var previews: some View {
        CategoryQuotesList(category: .init(name: "love", imageName: "http://"))
    }
}
