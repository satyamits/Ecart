//
//  HomeView.swift
//  Ecart
//
//  Created by Satyam Singh on 19/04/25.
//

import Foundation
import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel = HomeViewModel()
    @State private var selectedTab: Tab = .home
    @State private var cartItemCount = 2
    @State private var selectedProduct: ProductElement? = nil
    @State private var showDetail = false
    @StateObject var cartViewModel = CartViewModel()
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemGray6).ignoresSafeArea()
                VStack(spacing: 0) {
                    
                    contentView
                    Spacer()
                    TabBarView(selectedTab: $selectedTab, cartItemCount: cartViewModel.items.count)
                        .padding(.bottom, 8)
                }
                .ignoresSafeArea(edges: .bottom)
                NavigationLink(
                    destination: Group {
                        if let product = selectedProduct {
                            ProductDetailView(
                                product: product,
                                isLiked: Binding(
                                    get: { viewModel.favorites.contains(product.id ?? -1) },
                                    set: { newValue in viewModel.toggleLike(for: product) }
                                )
                            )
                            .environmentObject(cartViewModel)
                        } else {
                            EmptyView()
                        }
                    },
                    isActive: $showDetail,
                    label: {
                        EmptyView()
                    }
                )
                .hidden()

            }
            
        }
        .foregroundColor(Color.black)
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.hidden)
    }

    // MARK: Header
    var headerView: some View {
        VStack(spacing: 12) {
            HStack {
                Button {
                    // Handle left icon tap
                    
                } label: {
                    Image(systemName: "seal.fill")
                        .resizable()
                        .foregroundColor(.black)
                        .padding(16)
                        .frame(width: 50, height: 50)
                        .background(Color(.systemGreen).opacity(0.4))
                        .clipShape(Circle())
                }
                
                Spacer()
                
                VStack(spacing: 2) {
                    Text("Delivery address")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text("92 High Street, London")
                        .font(.headline)
                        .bold()
                }
                
                Spacer()
                
                Button {
                    
                    // Handle notification tap
                    
                } label :{
                    ZStack(alignment: .topTrailing) {
                        
                        Image(systemName: "bell")
                            .resizable()
                            .foregroundColor(.black)
                            .padding(16)
                            .frame(width: 50, height: 50)
                            .background(Color(.systemGray6))
                            .clipShape(Circle())
                        
                        
                        Circle()
                            .fill(Color.green)
                            .frame(width: 12, height: 12)
                            .offset(x: -4, y: -1)
                    }
                }
            }
            // Search Bar
            ZStack {
                HStack(spacing: 12) {
                    Spacer()
                    if self.viewModel.searchQuery.isEmpty {
                        Image(systemName: "magnifyingglass")
                            .resizable()
                            .foregroundColor(.gray)
                            .frame(width: 20, height: 20)
                        Text("Search the entire shop")
                            .foregroundColor(.gray)
                        Spacer() } else {
                            Button {
                                self.viewModel.searchQuery = ""
                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                            } label: {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 10)
                            }
                        }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(15)
                TextField("", text: self.$viewModel.searchQuery)
                    .padding(.horizontal, 8)
                    .background(Color.clear)
                    .foregroundColor(.black)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .onChange(of: self.viewModel.searchQuery) {
                        withAnimation {
                            self.viewModel.filterProducts()
                        }
                    }
            }
        }
        
        .padding(.horizontal, 18)
        .padding(.bottom, 12)
        .background(
            Color.white
                .ignoresSafeArea(edges: .top)
        )
        .clipShape(RoundedCorner(radius: 28, corners: [.bottomLeft, .bottomRight]))
        .shadow(color: .gray.opacity(0.1), radius: 4, x: 0, y: 2)
        
    }
    
    // MARK: ProductListView
    func productListingView(for homeViewModel: HomeViewModel) -> some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 24) {
                
                CategorySectionView(
                    categories: Array(Set(self.viewModel.products.compactMap { $0.category }))
                        .sorted(by: { $0.rawValue < $1.rawValue }),
                    selectedCategory: self.$viewModel.selectedCategory
                )
                .onChange(of: self.viewModel.selectedCategory) { _ in
                    withAnimation {
                        self.viewModel.filterProducts()
                    }
                }
                VStack(alignment: .leading, spacing: 12) {
                    if self.viewModel.timeRemaining > 0 {
                        HStack {
                            Text("Flash Sale")
                                .font(.title3).bold()
                            
                            HStack(spacing: 8) {
                                Text(self.viewModel.formattedFlashSaleTime())
                                    .font(.caption)
                                    .padding(6)
                                    .background(Color(.systemGreen).opacity(0.4))
                                    .cornerRadius(6)
                                Spacer()
                                SeeAllButton {
                                    // Handle tap
                                }
                            }
                        }
                    }
                    ZStack {
                        if self.viewModel.isLoading {
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
                                    let isLikedBinding = Binding(
                                        get: { self.viewModel.favorites.contains(product.id ?? -1) },
                                        set: { newValue in
                                            self.viewModel.toggleLike(for: product)
                                        }
                                    )

                                    NavigationLink {
                                        ProductDetailView(product: product, isLiked: isLikedBinding)
                                            .environmentObject(self.cartViewModel)
                                    } label: {
                                        ProductCardView(
                                            product: product,
                                            isFavorite: isLikedBinding
                                        ) {
                                            viewModel.toggleLike(for: product)
                                        }
                                    }
                                }
                            }

                        }
                    }
                }
            }
            .padding(.vertical)
            .padding(.horizontal, 18)
        }
        .background(Color.white)
        .clipShape(RoundedCorner(radius: 28, corners: [.topLeft, .topRight]))
        .shadow(color: .gray.opacity(0.1), radius: 4, x: 0, y: -2)
        
    }
    
    @ViewBuilder
    var contentView: some View {
        switch selectedTab {
        case .home:
            VStack {
                headerView
                Spacer().frame(height: 16)
                            .background(Color(.systemGray6).ignoresSafeArea())
                productListingView(for: viewModel)
            }
        case .catalog:
            Text("Catalog View")

        case .cart:
            CartView(viewModel: self.cartViewModel)

        case .favorites:
            FavoriteView(
                viewModel: viewModel,
                selectedProduct: $selectedProduct,
                showDetail: $showDetail
            )


        case .profile:
            Text("Profile View") 
        }
    }

    
}


#Preview {
    HomeView()
}
