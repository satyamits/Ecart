//
//  CartView.swift
//  Ecart
//
//  Created by Satyam Singh on 20/04/25.
//


import SwiftUI

// MARK: - SwiftUI View
struct CartView: View {
    @StateObject var viewModel: CartViewModel
    
    var body: some View {
        NavigationView {
            VStack(spacing: 12) {
                headerView
                
                VStack {
                    ScrollView {
                        HStack(spacing: 24) {
                            Button {
                                viewModel.toggleSelectAll()
                            } label: {
                                HStack {
                                    Image(systemName: self.viewModel.isSelectAll ? "checkmark.square.fill" : "square")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 24, height: 24)
                                        .foregroundColor(viewModel.isSelectAll ? .green : .gray)
                                    Text("Select all")
                                        .font(.subheadline.bold())
                                        .foregroundColor(.black)
                                    
                                }
                            }
                            Spacer()
                            Button {
                                print("Share tapped")
                            } label: {
                                Image(systemName: "square.and.arrow.up")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .foregroundColor(.black)
                                    .frame(width: 24, height: 24)
                            }
                            Button {
                                self.viewModel.isEditing.toggle()
                            } label: {
                                Image(systemName: self.viewModel.isEditing ? "pencil.line" : "square.and.pencil")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 24, height: 24)
                                    .foregroundColor(.black)
                            }
                            
                            
                        }
                        .padding(.vertical, 16)
                        // List of Cart Items
                        
                        LazyVStack {
                            ForEach(self.$viewModel.items) { $item in
                                CartItemRoww(viewModel: viewModel, item: $item)
                            }
                        }
                    }
                    
                    // Bottom Section: Checkout Button
                    VStack(spacing: 0) {
                        Divider()
                        if !viewModel.selectedItems.isEmpty {
                            HStack {
                                Text("Total:")
                                    .font(.headline)
                                Spacer()
                                Text("£\(viewModel.totalSelectedPrice, specifier: "%.2f")")
                                    .font(.headline)
                            }
                            .padding()
                        } else {
                            Text("Add Products to Cart")
                                .foregroundColor(Color.black)
                        }
                       
                        
                        Button {
                            // Handle checkout action
                            print("Checkout tapped with selected items: \(viewModel.selectedItems)")
                        } label: {
                            Text("Checkout")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(viewModel.selectedItems.isEmpty ? Color.gray : Color.green)
                                .cornerRadius(10)
                        }
                        .padding()
                        .disabled(viewModel.selectedItems.isEmpty)
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(12)
            }
            .background(Color(.systemGray6))
        }
    }
}

// MARK: - Cart Item Row View
struct CartItemRoww: View {
    
    @ObservedObject var viewModel: CartViewModel
    @Binding var item: CartItem
    
    var body: some View {
        HStack(spacing: 12) {
            if self.viewModel.isEditing {
                Button {
                    self.viewModel.toggleSelection(item: item)
                } label: {
                    Image(systemName: self.item.isSelected ? "checkmark.square.fill" : "square")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24, height: 24)
                        .foregroundColor(item.isSelected ? .green : .gray)
                }
                .buttonStyle(PlainButtonStyle())
                
            }
            
            AsyncImage(url: URL(string: self.item.imageURL ?? "")) { phase in
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
                        .frame(maxWidth: 90, maxHeight: 90)
                        .padding([.horizontal, .vertical], 12)
                        .background(Color.gray)
                        .cornerRadius(12)
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
                
            
            VStack(alignment: .leading, spacing: 34) {
                Text(item.name)
                    .font(.headline)
                HStack {
                    Text("£\(item.price, specifier: "%.2f")")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Spacer()
                    
                    HStack(spacing: 12) {
                        Button {
                            self.viewModel.decrementQuantity(item: item)
                        } label: {
                            Image(systemName: "minus.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 24, height: 24)
                                .foregroundColor(Color(.systemGray5))
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        Text("\(item.quantity)")
                            .font(.title3)
                        
                        Button {
                            self.viewModel.increaseQuantity(item: item)
                        } label: {
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 24, height: 24)
                                .foregroundColor(Color(.systemGray5))
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }
            
            
        }
        .onChange(of: self.viewModel.items.first(where: {
            $0.id == item.id })?.isSelected) { newValue, _ in
                if let newValue {
                    self.item.isSelected = newValue
                }
            }
    }
}

#Preview {
    CartView(viewModel: CartViewModel())
}
