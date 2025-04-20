//
//  Products.swift
//  Ecart
//
//  Created by Satyam Singh on 19/04/25.
//


import Foundation

// MARK: - ProductElement
struct ProductElement: Codable {
    var id: Int?
    var title: String?
    var price: Double?
    var description: String?
    var category: Category?
    var image: String?
    var rating: Rating?
    var isLiked: Bool? = false
}

enum Category: String, Codable {
    case electronics = "electronics"
    case jewelery = "jewelery"
    case menSClothing = "men's clothing"
    case womenSClothing = "women's clothing"
}

// MARK: - Rating
struct Rating: Codable {
    var rate: Double?
    var count: Int?
}

typealias Product = [ProductElement]
