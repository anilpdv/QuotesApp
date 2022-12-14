//
//  QuoteTileView.swift
//  QuotesApp
//
//  Created by anilpdv on 08/10/22.
//

import Kingfisher
import SwiftUI

struct QuoteTileView: View {
    let quote: QuoteObj

    var body: some View {
        ZStack {
            VStack(alignment: .center) {
                KFImage(URL(string: quote.img)!)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 55, height: 55)
                    .clipShape(Circle())
                Text(quote.quote)
                    .font(.custom("Avenir-Book", size: 20))
                    .foregroundColor(Color(hex: "5e6572"))
                    .tracking(0.6)

                Text("- \(quote.author)")
                    .font(.custom("Avenir-Book", size: 16))
                    .foregroundColor(Color(hex: "A9B4C2")).padding(.vertical, 2)
                    .tracking(0.6)
                HStack {
                    Spacer()
                }
            }.padding()
                .frame(width: 360)
            HStack {
                Spacer()
            }
        }.asTile().padding(.horizontal)
    }
}

struct QuoteTileView_Previews: PreviewProvider {
    static var previews: some View {
        QuoteTileView(quote: .init(author: "author", img: "djfkd", quote: "quote"))
    }
}
