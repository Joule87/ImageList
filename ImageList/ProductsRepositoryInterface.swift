//
//  ProductsRepositoryInterface.swift
//  ImageList
//
//  Created by Julio Collado Perez on 7/5/25.
//

import Foundation


protocol ProductsRepositoryInterface {
    func fetchProducts() async throws -> [Product]
}

actor ProductsRepository: ProductsRepositoryInterface {
    func fetchProducts() async throws -> [Product] {
        guard let url = URL(string: "https://fakestoreapi.com/products") else {
            throw NetworkError.urlError("❌ Bad URL")
        }
        let urlRequest = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.serviceError("❌ Bad HTTP status code")
        }
        let products:[Product]
        do {
            products = try JSONDecoder().decode([Product].self, from: data)
        } catch {
            throw NetworkError.decodingError("❌ decodingError: \(error.localizedDescription)")
        }
        
        return products
    }
}

enum NetworkError: Error {
    case serviceError(String)
    case urlError(String)
    case decodingError(String)
}
