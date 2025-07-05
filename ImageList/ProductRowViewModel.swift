//
//  ProductRowViewModel.swift
//  ImageList
//
//  Created by Julio Collado Perez on 7/5/25.
//

import Combine
import SwiftUI

final class ProductRowViewModel: ObservableObject {
    init(title: String, description: String, imageURL: String) {
        self.title = title
        self.description = description
        self.imageURL = imageURL
    }
    
    let title: String
    let description: String
    private let imageURL: String
}


