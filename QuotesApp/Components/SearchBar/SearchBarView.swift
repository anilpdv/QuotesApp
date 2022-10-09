//
//  SearchBarView.swift
//  QuotesApp
//
//  Created by anilpdv on 07/10/22.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String
    @EnvironmentObject var quotesModel: QuotesListModel
    @State private var showGreeting = false
    @State var shouldShowFullScreenModal = false
    var body: some View {
        HStack {
            HStack {
                VStack {
                    ScrollView {
                        Spacer().fullScreenCover(isPresented: $shouldShowFullScreenModal) {
                            ZStack(alignment: .topLeading) {
                                Color(hex: "EEF1EF").ignoresSafeArea()
                                VStack {
                                    HStack {
                                        Spacer()
                                        Text("\(searchText)")
                                            .font(.custom("Avenir-Heavy", size: 30))
                                            .foregroundColor(Color(hex: "1C2321"))
                                            .padding()
                                            .tracking(0.6)
                                            
                                        Spacer()
                                    }

                                    if quotesModel.isLoading {
                                        HStack {
                                            Spacer()
                                            ActivityIndicatorView().frame(width: 400, height: 500)
                                            Spacer()
                                        }
                                    } else {
                                        if !quotesModel.errorMessage.isEmpty {
                                            HStack {
                                                Spacer()
                                                VStack {
                                                    Spacer()
                                                    Image(systemName: "x.circle.fill")
                                                        .foregroundColor(.red)
                                                        .font(.system(size: 50, weight: .bold))
                                                        .padding()
                                                    Text(quotesModel.errorMessage)
                                                        .font(.system(size: 12, weight: .bold))
                                                        .foregroundColor(Color(hex: "1C2321"))
                                                    Spacer()
                                                }
                                                Spacer()
                                            }

                                        } else {
                                            ScrollView {
                                                ForEach(quotesModel.searchRes?.quotes ?? [], id: \.self) { quote in

                                                    QuoteTileView(quote: quote)
                                                }
                                            }
                                        }
                                    }
                                }

                                Button(action: {
                                    shouldShowFullScreenModal.toggle()
                                }) {
                                    Image(systemName: "xmark.circle").font(.system(size: 30, weight: .bold))
                                        .foregroundColor(Color(hex: "1C2321")).opacity(0.7)
                                        .padding()
                                }
                            }
                        }.opacity(shouldShowFullScreenModal ? 1 : 0)
                    }
                }
                Image(systemName: "magnifyingglass")

                // Search text field
                ZStack(alignment: .leading) {
                    if searchText.isEmpty { // Separate text for placeholder to give it the proper color
                        Text("Search")
                    }

                    TextField("", text: $searchText, onCommit: {
                    }).foregroundColor(.white).font(.system(size: 14, weight: .semibold)).tracking(0.8).onSubmit {
                        guard searchText.isEmpty == false else { return }
                        self.quotesModel.searchQuotes(query: searchText)

                        shouldShowFullScreenModal = true
                    }
                }

                // Clear button
                Button(action: {
                    self.searchText = ""
                }) {
                    Image(systemName: "xmark.circle.fill").opacity(searchText == "" ? 0 : 1)
                }
            }

            .font(.system(size: 14, weight: .semibold))
            .foregroundColor(.white)
            .padding()
            .background(Color(.init(white: 1, alpha: 0.2)))
            .cornerRadius(13)
            .padding(14)
        }
    }
}

struct SearchBarView_Previews: PreviewProvider {
    @State static var searchText = ""
    static var previews: some View {
        SearchBarView(searchText: $searchText)
    }
}
