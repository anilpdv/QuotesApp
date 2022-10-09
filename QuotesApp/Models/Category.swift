//
//  Category.swift
//  QuotesApp
//
//  Created by anilpdv on 08/10/22.
//

import Foundation

struct Category: Hashable {
    let name, imageName: String
}

class CategoryQuotesListModel: ObservableObject {
    @Published var isLoading = false
    @Published var res: Quotes?

    init(categoryName: String) {
        let urlString = "\(BASE_URL)/tag/\(categoryName.lowercased())"
        isLoading = true
        guard let url = URL(string: urlString) else { return }

        DispatchQueue.main.async {
            URLSession.shared.dataTask(with: url) { data, _, _ in
                guard let data = data else { return }
                self.res = try? JSONDecoder().decode(Quotes.self, from: data)
                self.isLoading = false
            }.resume()
            self.isLoading = false
        }
    }

    func loadPage(categoryName: String, pageId: Int) {
        let urlString = "\(BASE_URL)/tag/\(categoryName.lowercased())?page=\(pageId)"
        isLoading = true
        guard let url = URL(string: urlString) else { return }

        DispatchQueue.main.async {
            URLSession.shared.dataTask(with: url) { data, _, _ in
                guard let data = data else { return }
                do {
                    self.res = try JSONDecoder().decode(Quotes.self, from: data)
                    self.isLoading = false
                } catch {
                    print("Failed to decode json ", error)
                }
                self.isLoading = false
            }.resume()
        }
    }
}
