//
//  ProductRowViewModel.swift
//  ImageList
//
//  Created by Julio Collado Perez on 7/5/25.
//

import Combine
import SwiftUI
import UIKit

final class ProductRowViewModel: ObservableObject {
    enum ImageState {
        case isLoading
        case error
        case image(UIImage)
    }
    
    @MainActor @Published private(set) var imageState: ImageState = .isLoading
    private var imageLoader: RemoveImageLoader
    
    let title: String
    let description: String
    let price: Double
    private let imageStringURL: String
    
    init(title: String,
         description: String,
         price: Double,
         imageURL: String,
         imageLoader: RemoveImageLoader = ImageLoader()) {
        self.title = title
        self.description = description
        self.price = price
        self.imageStringURL = imageURL
        self.imageLoader = imageLoader
    }
    
    @MainActor
    func fetchImage() async {
        imageState = .isLoading
        guard let url = URL(string: imageStringURL) else {
            imageState = .error
            return
        }
        
        do {
            let uiImage = try await imageLoader.fetchImage(url: url)
            imageState = .image(uiImage)
        } catch {
            imageState = .error
        }
    }
}


