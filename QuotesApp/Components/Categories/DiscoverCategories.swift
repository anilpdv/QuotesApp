//
//  DiscoverCategories.swift
//  QuotesApp
//
//  Created by anilpdv on 07/10/22.
//

import SwiftUI

struct NavigationLazyView<Content: View>: View {
    let build: () -> Content
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }

    var body: Content {
        build()
    }
}

struct DiscoverCategories: View {
    let categories: [Category] = [
        .init(name: "Love", imageName: "heart.fill"),
        .init(name: "Life", imageName: "leaf.circle.fill"),
        .init(name: "Inspirational", imageName: "hands.clap.fill"),
        .init(name: "Humor", imageName: "face.smiling.inverse"),
        .init(name: "Philosophy", imageName: "brain.head.profile"),
        .init(name: "Truth", imageName: "compass.drawing"),
        .init(name: "Wisdom", imageName: "doc.text.magnifyingglass"),
        .init(name: "Poetry", imageName: "signature"),
        .init(name: "Romance", imageName: "person.2.fill"),
        .init(name: "Death", imageName: "flame.fill"),
        .init(name: "Happiness", imageName: "figure.mixed.cardio"),
        .init(name: "Hope", imageName: "sailboat.fill"),
        .init(name: "Faith", imageName: "bird.fill"),
        .init(name: "Writing", imageName: "theatermask.and.paintbrush.fill"),
        .init(name: "Motivational", imageName: "figure.run"),
        .init(name: "Religion", imageName: "book.fill"),
        .init(name: "Spirituality", imageName: "moon.stars.circle.fill"),
        .init(name: "Relationships", imageName: "figure.2.arms.open"),
        .init(name: "Success", imageName: "party.popper.fill"),
        .init(name: "Time", imageName: "timer.circle.fill"),
        .init(name: "Knowledge", imageName: "globe.central.south.asia.fill"),
        .init(name: "Science", imageName: "function"),
    ]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top, spacing: 16) {
                ForEach(categories, id: \.self) { category in
                    NavigationLink(destination: { CategoryQuotesList(category: category) }, label: {
                        VStack(spacing: 5) {
                            Image(systemName: category.imageName)
                                .font(.custom("Avenir-Book", size: 24))
                                .foregroundColor(Color(hex: "7d98a1"))
                                .frame(width: 60, height: 60)
                                .background(Color(hex: "eef1ef"))
                                .cornerRadius(68)

                            Text(category.name)
                                .font(.custom("Avenir-Heavy", size: 10))
                                .multilineTextAlignment(.center)
                                .foregroundColor(.white)

                        }.frame(width: 70)
                    })
                }
            }.padding(.horizontal)
        }
    }
}

struct DiscoverCategories_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverCategories()
    }
}
