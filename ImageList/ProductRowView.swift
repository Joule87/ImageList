//
//  ProductRowView.swift
//  ImageList
//
//  Created by Julio Collado Perez on 7/5/25.
//

import SwiftUI

struct ProductRowView: View {
    @ObservedObject var viewModel: ProductRowViewModel

    var body: some View {
        VStack {
            HStack(spacing: 16) {
                imageView
                    .frame(width: 80, height: 80)
                ProductView(title: viewModel.title, description: viewModel.description, price: viewModel.price)
            }
            .padding(.vertical, 8)
            Divider()
        }
        .task {
            await viewModel.fetchImage()
        }
    }
    
    @ViewBuilder
    var imageView: some View {
        switch viewModel.imageState {
        case .isLoading:
            ProgressView()
        case .error:
            Image(systemName: "xmark.circle.fill")
                .foregroundColor(.red)
        case .image(let image):
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
        }
    }
}
