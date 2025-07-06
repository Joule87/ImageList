//
//  ProductDetailsViewModel.swift
//  ImageList
//
//  Created by Julio Collado Perez on 7/6/25.
//
import Combine
import Foundation

final class ProductDetailsViewModel: ObservableObject {
    
    @Published private(set) var countDownOffer: Int = 60
    @Published private(set) var isOfferActive: Bool = true
    
    let product: Product
    private var timerCancellable: AnyCancellable?
    
    init(product: Product) {
        self.product = product
    }

    func startCountDownOfferOFF() async {
        timerCancellable = Timer.publish(every: 1, on: .main, in: .default)
            .autoconnect()
            .sink { _ in
                if self.countDownOffer > 0 {
                    self.countDownOffer -= 1
                } else {
                    self.isOfferActive = false
                    self.timerCancellable?.cancel()
                    self.timerCancellable = nil
                }
                
            }
        
    }
}
