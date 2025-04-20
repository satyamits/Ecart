//
//  CartItem.swift
//  Ecart
//
//  Created by Satyam Singh on 20/04/25.
//

import Foundation

struct CartItem: Identifiable {
    let id: Int
    let name: String
    let price: Double
    var quantity: Int
    var isSelected: Bool
    var imageURL: String?
}
