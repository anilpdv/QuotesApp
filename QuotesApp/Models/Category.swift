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

struct Place: Decodable, Hashable {
    let name, thumbnail: String
}
