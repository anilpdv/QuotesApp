//
//  QuotesList.swift
//  QuotesApp
//
//  Created by anilpdv on 08/10/22.
//

import Kingfisher
import SwiftUI

struct QuotesList: View {
    @EnvironmentObject var quotesModel: QuotesListModel
    @State var currentIndex = 1
    var body: some View {
        ScrollView(.vertical) {
            if quotesModel.isLoading {
                HStack {
                    ActivityIndicatorView().frame(width: 400, height: 500)
                    Spacer()
                }
            } else {
                VStack {
                    ForEach(quotesModel.res?.quotes ?? [], id: \.self) { quote in

                        QuoteTileView(quote: quote)
                    }

                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(1 ..< 101, id: \.self) { num in
                                Button(action: {
                                    self.quotesModel.loadPage(pageId: num)
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
                    }.opacity(quotesModel.isLoading ? 0 : 1)
                }
            }
        }
    }
}

struct QuotesList_Previews: PreviewProvider {
    static var previews: some View {
        QuotesList().environmentObject(QuotesListModel())
    }
}
