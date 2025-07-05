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
        ZStack {
            Color.cyan.edgesIgnoringSafeArea(.all).opacity(0.1)
            VStack {
                Text("Products")
                    .font(.largeTitle)
                Spacer()
                if viewModel.isLoaing {
                    ProgressView()
                } else {
                    content
                }
                Spacer()
            }
        }
        .task {
            await viewModel.fetchProducts()
        }
    }
    
    var content: some View {
        ScrollView {
            LazyVStack(alignment: .leading) {
                ForEach(viewModel.products, id: \.id) { product in
                    ProductRowView(viewModel: .init(title: product.title,
                                                    description: product.description,
                                                    imageURL: product.image)
                    )
                }
            }
        }
        .padding()
    }
}

#Preview {
    ProductsView()
}
