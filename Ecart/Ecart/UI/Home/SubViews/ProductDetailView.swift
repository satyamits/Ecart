//
//  ProductDetailView.swift
//  Ecart
//
//  Created by Satyam Singh on 20/04/25.
//


import SwiftUI

struct ProductDetailView: View {
    
    @EnvironmentObject var cartViewModel: CartViewModel
    var product: ProductElement
    @Binding var isLiked: Bool
    @Environment(\.dismiss) var dismiss
    @State private var showFullDescription = false
    
    var body: some View {
        ZStack {
            // Background Image
            VStack {
                
                HStack {
                    Button(action: { dismiss() }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.black)
                            .padding()
                            .background(Color.white.opacity(0.9))
                            .clipShape(Circle())
                    }
                    
                    Spacer()
                    
                    
                    HStack(spacing: 12) {
                        Button {
                            isLiked.toggle()
                        } label: {
                            Image(systemName: isLiked ? "heart.fill" : "heart")
                                .foregroundColor(isLiked ? .red : .black)
                                .padding()
                                .background(Color.white.opacity(0.9))
                                .clipShape(Circle())
                        }
                        
                        Button {
                            self.cartViewModel.addToCart(product: product)
                        } label: {
                            Image(systemName: "square.and.arrow.up")
                                .foregroundColor(.black)
                                .padding()
                                .background(Color.white.opacity(0.9))
                                .clipShape(Circle())
                        }
                    }
                }
                .padding(.horizontal, 18)
                .padding(.top, 45)
                
                AsyncImage(url: URL(string: product.image ?? "")) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: 150)
                } placeholder: {
                    Color.gray.opacity(0.2)
                        .frame(height: 300)
                }
                .frame(height: 300)
                Spacer()
            }
            .background(RoundedRectangle(cornerRadius: 8)
                .fill(Color.gray.opacity(0.2)))
            .ignoresSafeArea(edges: .vertical)
            
            
            // Foreground Scroll Content
            VStack(spacing: 16) {
                Spacer()
                    .frame(height: UIScreen.main.bounds.height * (self.showFullDescription ? 0.4 : 0.5))
                
                VStack {
                    ScrollView(showsIndicators: false) {
                        VStack(alignment: .leading, spacing: 12) {
                            Text(product.title ?? "No Title")
                                .font(.title2.bold())
                            
                            HStack(spacing: 12) {
                                RatingView(type: .rating(value: 4.8, count: 117))
                                RatingView(type: .likes(count: 42))
                                RatingView(type: .comments(count: 7))
                            }
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            
                            Text("£\(product.price ?? 0.0, specifier: "%.2f")")
                                .font(.title3.bold())
                            
                            Group {
                                Text(self.product.description ?? "")
                                    .lineLimit(self.showFullDescription ? nil : 3)
                                    .foregroundColor(.gray)
                                
                                Button {
                                    withAnimation {
                                        self.showFullDescription.toggle()
                                    }
                                } label: {
                                    Text(showFullDescription ? "Read less" : "Read more")
                                        .font(.footnote)
                                        .bold()
                                }
                            }
                        }
                    }
                    if cartViewModel.quantityInCart(for: product) == 0 {
                        Button {
                            withAnimation {
                                cartViewModel.addToCart(product: product)
                            }
                        } label: {
                            Text("Add to Cart")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(12)
                        }
                        .padding(.horizontal)
                    } else {
                        HStack {
                            Button {
                                withAnimation {
                                    self.cartViewModel.decrementQuantity(for: product)
                                }
                            } label: {
                                Image(systemName: "minus.circle.fill")
                                    .font(.title2)
                                    .foregroundColor(.red)
                            }

                            Text("In Cart: \(self.cartViewModel.quantityInCart(for: product))")
                                .font(.headline)
                                .frame(minWidth: 80)

                            Button {
                                withAnimation {
                                    self.cartViewModel.incrementQuantity(for: product)
                                }
                            } label: {
                                Image(systemName: "plus.circle.fill")
                                    .font(.title2)
                                    .foregroundColor(.green)
                            }
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                        .padding(.horizontal)
                    }
                    
                    Text("Delivery on 26 October")
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .padding(.top, 4)
                }
                .padding()
                .background(
                    Color.white
                        .cornerRadius(24)
                        .shadow(radius: 5)
                )
                .offset(y: 32)
            }
        }
        .navigationBarHidden(true)
    }
}
