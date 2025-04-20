//
//  HomeViewModel.swift
//  Ecart
//
//  Created by Satyam Singh on 19/04/25.
//


import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var products: [ProductElement] = []
    @Published var filteredProducts: [ProductElement] = []
    @Published var selectedCategory: Category? = nil
    @Published var searchText: String = ""
    @Published var isLoading: Bool = false
    @Published var favorites: Set<Int> = []
    @Published var searchQuery: String = ""
    
    @Published var timeRemaining: TimeInterval = 3 * 60 * 60
    private var timer: Timer?
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        self.startFlashSaleTimer()
        self.fetchProducts()
    }
    
    func fetchProducts() {
        guard let url = URL(string: "https://fakestoreapi.com/products") else { return }
        
        self.isLoading = true
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [ProductElement].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .sink { [weak self] products in
                self?.products = products
                self?.isLoading = false
                self?.filterProducts()
            }
            .store(in: &cancellables)
    }
    
    func toggleLike(for product: ProductElement) {
        guard let productId = product.id else { return }
        if self.favorites.contains(productId) {
            self.favorites.remove(productId)
        } else {
            self.favorites.insert(productId)
        }
        
        self.filterProducts()
    }
    
    func filterProducts() {
        
        let query = searchQuery.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        
        
        let filtered = products.filter { product in
            
            let matchesSearch: Bool = {
                guard !query.isEmpty else { return true }
                
                let titleMatch = product.title?.lowercased().contains(query) ?? false
                let descriptionMatch = product.description?.lowercased().contains(query) ?? false
                let categoryMatch = product.category?.rawValue.lowercased().contains(query) ?? false
                
                return titleMatch || descriptionMatch || categoryMatch
            }()
            
            
            let matchesCategory = selectedCategory == nil || product.category == selectedCategory
            
            return matchesSearch && matchesCategory
        }
        
        
        self.filteredProducts = filtered.sorted { lhs, rhs in
            let lhsIsFav = favorites.contains(lhs.id ?? -1)
            let rhsIsFav = favorites.contains(rhs.id ?? -1)
            
            return lhsIsFav && !rhsIsFav
        }
        
        self.isLoading = false
    }
    
    func startFlashSaleTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
            } else {
                self.timer?.invalidate()
                self.timer = nil
            }
        }
    }
    
    func formattedFlashSaleTime() -> String {
        guard timeRemaining > 0 else { return "Flash Sale is Over" }
        
        let hours = Int(timeRemaining) / 3600
        let minutes = (Int(timeRemaining) % 3600) / 60
        let seconds = Int(timeRemaining) % 60
        
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    
    func getLikedProducts() -> [ProductElement] {
        return products.filter { favorites.contains($0.id ?? -1) }
    }
    
}
