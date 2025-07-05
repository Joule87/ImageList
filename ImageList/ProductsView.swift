//
//  ProductsView.swift
//  ImageList
//
//  Created by Julio Collado Perez on 7/4/25.
//

import SwiftUI

struct ProductsView: View {
    @StateObject var viewModel: ProductsViewModel = .init()
    
    var body: some View {
            NavigationStack {
                VStack {
                    if viewModel.isLoaing {
                        ProgressView()
                    } else {
                        content
                    }
                }
                .navigationTitle(
                    Text("Products")
                )
                .navigationBarTitleDisplayMode(.inline)
                .navigationDestination(for: Product.self) { product in
                    ProductView(title: product.title,
                                description: product.description,
                                price: product.price)
                }
            }
        .task {
            await viewModel.fetchProducts()
        }
    }
    
    private var content: some View {
        ScrollView {
            LazyVStack(alignment: .leading) {
                ForEach(viewModel.products, id: \.id) { product in
                    makeProductRowView(with: product)
                }
            }
        }
        .padding()
    }
    
    private func makeProductRowView(with product: Product) -> some View {
        NavigationLink(value: product) {
            ProductRowView(viewModel: .init(title: product.title,
                                            description: product.description,
                                            price: product.price,
                                            imageURL: product.image)
            )
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    ProductsView()
}
