//
//  ProductListView.swift
//  Ecart
//
//  Created by Satyam Singh on 19/04/25.
//


import SwiftUI

struct ProductListView: View {
    
    @StateObject var viewModel: HomeViewModel
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        ZStack {
            if viewModel.isLoading {
                Color.black.opacity(0.05).ignoresSafeArea()
                ProgressView("Loading...")
                    .progressViewStyle(CircularProgressViewStyle(tint: .green))
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 10)
            } else {
                
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(viewModel.filteredProducts, id: \.id) { product in
                        ProductCardView(
                            product: product,
                            isFavorite: Binding(
                                get: { viewModel.favorites.contains(product.id!) },
                                set: { isFavorite in
                                    viewModel.toggleLike(for: product)
                                })) {
                                    viewModel.toggleLike(for: product)
                                }
                    }
                }
            }
        }
    }
}

#Preview {
    ProductListView(viewModel: HomeViewModel())
}
