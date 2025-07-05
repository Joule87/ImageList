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
                    .frame(width: 44, height: 44)
                VStack(alignment: .leading) {
                    Text(viewModel.title)
                        .font(.headline)
                    Text(viewModel.description)
                        .font(.caption)
                }
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
