//
//  ProductListingItem.swift
//  DevoteamTest
//
//  Created by Joel Sene on 26/05/2024.
//

import SwiftUI

struct ProductListingItem: View {
    @State var product: Product
    
    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: 8) {
                AsyncImage(url: URL(string: product.thumbnail ?? "")) { image in
                    image.resizable()
                } placeholder: {
                    Color.gray
                }
                .frame(width: 50, height: 50)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                VStack(alignment: .leading, spacing: 8) {
                    Text(product.title)
                        .font(.headline)
                    HStack {
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                        Text("\(product.rating, specifier: "%.2f")")
                            .font(.subheadline)
                        Spacer()
                    }
                    .underline()
                    .fontWeight(.semibold)
                }
            }
            .padding()
        }
    }
}

