//
//  ProductView.swift
//  ImageList
//
//  Created by Julio Collado Perez on 7/5/25.
//

import SwiftUI

struct ProductView: View {
    let title: String
    let description: String
    let price: Double
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white)
                .shadow(color: .gray.opacity(0.2), radius: 5, x: 0, y: 2)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .lineLimit(2)
                
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .lineLimit(3)
                
                Text("$\(String(format: "%.2f", price))")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.green)
            }
            .padding()
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .contentShape(Rectangle())
    }
}

#Preview {
    ProductView(title: "ASKdn akdjk ansdkjna ksjd aksd", description: "asndajks dnajksn djkansdja nda ksdnakj nkjasdfbkasdb fhsda fjassjf asjhfos jdfoisdjf oidsoifsdjif sidfj ids jfos", price: 23.32)
}
