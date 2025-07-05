//
//  RemoveImageLoader.swift
//  ImageList
//
//  Created by Julio Collado Perez on 7/5/25.
//

import SwiftUI

protocol RemoveImageLoader {
    func fetchImage(url: URL) async throws -> UIImage
}

final class ImageLoader: RemoveImageLoader {
  
    private let cache = NSCache<NSString, UIImage>()
    private var urlSession: URLSession
    
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func fetchImage(url: URL) async throws -> UIImage {
        if let cachedImage = cache.object(forKey: url.absoluteString as NSString)  {
            return cachedImage
        }
        
        let (data, response) = try await urlSession.data(from: url)
        
        guard let httpURLResponse = response as? HTTPURLResponse, (200...299).contains(httpURLResponse.statusCode) else {
            throw NetworkError.serviceError("Bad Response")
        }
        
        guard let image = UIImage(data: data) else {
            throw NetworkError.invalidData
        }
        cache.setObject(image, forKey: url.absoluteString as NSString)
        return image
    }
}
