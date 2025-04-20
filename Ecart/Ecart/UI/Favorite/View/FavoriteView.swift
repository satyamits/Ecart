//
//  FavoriteView.swift
//  Ecart
//
//  Created by Satyam Singh on 20/04/25.
//

import Foundation
import SwiftUI

import SwiftUI

struct FavoriteView: View {
    @ObservedObject var viewModel: HomeViewModel
    @Binding var selectedProduct: ProductElement?
    @Binding var showDetail: Bool

    var body: some View {
        if viewModel.getLikedProducts().isEmpty {
            VStack {
                Spacer()
                Text("No favorites yet")
                    .font(.headline)
                    .foregroundColor(.secondary)
                Spacer()
            }
        } else {
            ScrollView {
                LazyVStack(spacing: 12) {
                    ForEach(viewModel.getLikedProducts(), id: \.id) { product in
                        let isLiked = Binding(
                            get: { viewModel.favorites.contains(product.id ?? -1) },
                            set: { _ in viewModel.toggleLike(for: product) }
                        )
                        
                        ProductCardView(product: product, isFavorite: isLiked) {
                            viewModel.toggleLike(for: product)
                        }
                        .onTapGesture {
                            selectedProduct = product
                            showDetail = true
                        }
                    }
                }
                .padding()
            }
        }
    }
}




