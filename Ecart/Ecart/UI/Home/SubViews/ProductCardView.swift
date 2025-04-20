//
//  ProductCardView.swift
//  Ecart
//
//  Created by Satyam Singh on 19/04/25.
//


import SwiftUI

struct ProductCardView: View {
    
    @State var product: ProductElement
    @Binding var isFavorite: Bool
    var likeTapped: () -> Void
    var lineLimit: Int?

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack {
                AsyncImage(url: URL(string: self.product.image ?? "")) { phase in
                    switch phase {
                    case .empty:
                        ZStack {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.gray.opacity(0.2))
                                .frame(height: 140)
                            ProgressView()
                        }
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding()
                            .frame(maxHeight: 140)
                    case .failure:
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.red.opacity(0.3))
                            .frame(height: 140)
                            .overlay(
                                Image(systemName: "xmark.octagon.fill")
                                    .foregroundColor(.red)
                            )
                    @unknown default:
                        EmptyView()
                    }
                }
                
                VStack {
                    HStack {
                        Spacer()
                    Button {
                        withAnimation {
                            self.likeTapped()
                        }
                    } label: {
                        Image(systemName: self.isFavorite ? "heart.fill" : "heart")
                            .padding(8)
                            .foregroundColor(self.isFavorite ? .red : .gray)
                            .background(Color.white)
                            .clipShape(Circle())
                            .shadow(radius: 2)
                    }
                    .padding(6)
                    }
                    Spacer()
                }
            }
            .background(RoundedRectangle(cornerRadius: 8)
                .fill(Color.gray.opacity(0.2))
                .frame(height: 140))
            
            if let title = self.product.title {
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.leading)
                    .lineLimit(self.lineLimit == 0 ? 0 : 2)
                    .padding(.horizontal, 8)

            }
            
            HStack(spacing: 6) {
                Text("\u{00A3}\(String(format: "%.2f", self.product.price ?? 0.0))")
                    .font(.headline)

                if let price = self.product.price {
                    Text("\u{00A3}\(String(format: "%.2f", price + 30))")
                        .font(.subheadline)
                        .strikethrough()
                        .foregroundColor(.gray)
                }
            }
            .padding(.horizontal, 8)
        }
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
    }
}

#Preview {
    ProductCardView(product: ProductElement(id: 1, title: "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops", price: 109.99, description: "Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday", image: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg"), isFavorite: Binding.constant(false), likeTapped: {}, lineLimit: 2)
}
