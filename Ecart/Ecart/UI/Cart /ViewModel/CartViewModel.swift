//
//  CartViewModel.swift
//  Ecart
//
//  Created by Satyam Singh on 20/04/25.
//

import Foundation


class CartViewModel: ObservableObject {
    
    @Published var items: [CartItem] = []
    @Published var isSelectAll: Bool = false
    @Published var isEditing: Bool = false

    var selectedItems: [CartItem] {
        self.items.filter { $0.isSelected }
    }

    var totalSelectedPrice: Double {
        self.selectedItems.reduce(0) { $0 + $1.price * Double($1.quantity) }
    }

    func toggleSelectAll() {
        isSelectAll.toggle()
        for i in 0..<items.count {
            items[i].isSelected = isSelectAll
        }
    }

    func toggleSelection(item: CartItem) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index].isSelected.toggle()
            // Update isSelectAll based on the new selection state
            isSelectAll = items.allSatisfy { $0.isSelected }
        }
    }

    func quantityInCart(for product: ProductElement) -> Int {
        guard let name = product.title else { return 0 }
        return items.first(where: { $0.name == name })?.quantity ?? 0
    }


    
    func incrementQuantity(for product: ProductElement) {
        guard let id = product.id else { return }
        if let index = items.firstIndex(where: { $0.id == id }) {
            items[index].quantity += 1
        }
    }

    func decrementQuantity(for product: ProductElement) {
        guard let id = product.id else { return }
        if let index = items.firstIndex(where: { $0.id == id }) {
            if items[index].quantity > 1 {
                items[index].quantity -= 1
            } else {
                items.remove(at: index)
            }
        }
    }

    func increaseQuantity(item: CartItem) {
        if let index = items.firstIndex(where: { $0.name == item.name }) {
            items[index].quantity += 1
        }
    }

    func decrementQuantity(item: CartItem) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            if items[index].quantity > 1 {
                items[index].quantity -= 1
            } else {
                items.remove(at: index)
            }
        }
    }

    
    func addToCart(product: ProductElement) {
        guard let id = product.id, let name = product.title, let price = product.price, let imageUrl = product.image else { return }

        if let index = self.items.firstIndex(where: { $0.name == name }) {
            self.items[index].quantity += 1
        } else {
            let newItem = CartItem(
                id: id,
                name: name,
                price: price,
                quantity: 1,
                isSelected: false,
                imageURL: imageUrl
            )
            items.append(newItem)
        }
    }
}
