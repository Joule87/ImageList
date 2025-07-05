//
//  ProductsViewModel.swift
//  ImageList
//
//  Created by Julio Collado Perez on 7/5/25.
//

import Combine
import Foundation

final class ProductsViewModel: ObservableObject {
    @MainActor @Published var products: [Product] = []
    @MainActor @Published var isLoaing: Bool = false
    
    private let repository: ProductsRepositoryInterface
    
    init(repository: ProductsRepositoryInterface = ProductsRepository()) {
        self.repository = repository
    }
    
    @MainActor
    func fetchProducts() async {
        isLoaing = true
        do {
            products = try await repository.fetchProducts()
        } catch {
            print("\(error.localizedDescription)")
        }
        
        isLoaing = false
    }
}
