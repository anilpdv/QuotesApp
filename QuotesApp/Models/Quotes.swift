//
//  Quotes.swift
//  QuotesApp
//
//  Created by anilpdv on 10/10/22.
//

import Foundation

struct Quotes: Decodable {
    var quotes: [QuoteObj]
}

struct SearchQuotes: Decodable {
    var quotes: [QuoteObj]
}

struct QuoteObj: Decodable, Hashable {
    let author, img, quote: String
}

class QuotesListModel: ObservableObject {
    @Published var isLoading = false
    @Published var res: Quotes?
    @Published var searchRes: SearchQuotes?
    @Published var errorMessage = ""

    init() {
        let urlString = "\(BASE_URL)/quotes"
        isLoading = true
        guard let url = URL(string: urlString) else { return }

        DispatchQueue.main.async {
            URLSession.shared.dataTask(with: url) { data, resp, _ in
                if let statusCode = (resp as? HTTPURLResponse)?.statusCode, statusCode >= 400 {
                    self.isLoading = false
                    self.errorMessage = "Error Message: \(statusCode)"
                    return
                }
                guard let data = data else { return }
                do {
                    self.res = try JSONDecoder().decode(Quotes.self, from: data)
                    self.isLoading = false
                } catch {
                    self.isLoading = false
                    print("Failed to decode json", error)
                }
                self.isLoading = false
            }.resume()
        }
    }

    func loadPage(pageId: Int) {
        let urlString = "\(BASE_URL)/quotes?page=\(pageId)"
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

    func searchQuotes(query: String) {
        let urlString = "\(BASE_URL)/search?q=\(query)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        isLoading = true
        guard let url = URL(string: urlString) else { return }

        DispatchQueue.main.async {
            URLSession.shared.dataTask(with: url) { data, resp, error in
                if let statusCode = (resp as? HTTPURLResponse)?.statusCode, statusCode >= 400 {
                    self.isLoading = false
                    self.errorMessage = "Error Message: \(statusCode)"
                    return
                }

                guard let data = data else { return }
                do {
                    self.searchRes = try JSONDecoder().decode(SearchQuotes.self, from: data)
                    self.isLoading = false
                } catch {
                    print("Failed to decode json", error)
                }

                self.isLoading = false
            }.resume()
        }
    }
}
