//
//  Product.swift
//  ImageList
//
//  Created by Julio Collado Perez on 7/5/25.
//

import Foundation

struct Product: Codable, Equatable, Hashable {
    static func == (lhs: Product, rhs: Product) -> Bool {
        lhs.id == rhs.id
    }
    
    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: String
    let image: String
    let rating: Rating
    
    struct Rating: Codable, Hashable {
        let rate: Double
        let count: Int
    }
}
