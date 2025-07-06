//
//  ProductDetailsView.swift
//  ImageList
//
//  Created by Julio Collado Perez on 7/6/25.
//
import SwiftUI

struct ProductDetailsView: View {
    @ObservedObject var viewModel: ProductDetailsViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
                ProductView(title: viewModel.product.title,
                            description: viewModel.product.description,
                            price: viewModel.product.price)
            
            HStack{
                Spacer()
                Text("Offer expires in \(viewModel.countDownOffer) seconds")
                    .font(.footnote)
                    .fontWeight(.semibold)
                    .foregroundStyle(.black)
                    .strikethrough(!viewModel.isOfferActive, color: .red)
                
            }
            .padding(.horizontal)
            
            
                Spacer()
                .frame(alignment: .top)
        }
        .task {
            await self.viewModel.startCountDownOfferOFF()
        }
    }
}

#Preview {
    ProductDetailsView(viewModel: .init(product: .init(id: 1, title: "T-check", price: 2.33, description: "asd jand jas dnjas d", category: "Splpapers", image: "x.mark", rating: .init(rate: 5, count: 10))))
}
