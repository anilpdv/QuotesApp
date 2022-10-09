//
//  CategoryQuoesList.swift
//  QuotesApp
//
//  Created by anilpdv on 08/10/22.
//

import SwiftUI

struct CategoryQuotesList: View {
    let category: Category

    @ObservedObject var vm: CategoryQuotesListModel
    @State var currentIndex = 1

    init(category: Category) {
        self.category = category
        vm = .init(categoryName: category.name)
    }

    var body: some View {
        ScrollView {
            if vm.isLoading {
                HStack {
                    ActivityIndicatorView().frame(width: 400, height: 500)
                    Spacer()
                }
            } else {
                VStack {
                    ForEach(vm.res?.quotes ?? [], id: \.self) { quote in

                        QuoteTileView(quote: quote)
                    }

                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(1 ..< 101, id: \.self) { num in
                                Button(action: {
                                    self.vm.loadPage(categoryName: category.name, pageId: num)
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
                    }.opacity(vm.isLoading ? 0 : 1)
                }
            }

        }.navigationBarTitle(category.name)
    }
}

struct CategoryQuotesList_Previews: PreviewProvider {
    static var previews: some View {
        CategoryQuotesList(category: .init(name: "love", imageName: "http://"))
    }
}
