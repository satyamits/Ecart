//
//  RatingView.swift
//  Ecart
//
//  Created by Satyam Singh on 20/04/25.
//


import SwiftUI

enum RatingViewType {
    case rating(value: Double, count: Int?)
    case likes(count: Int)
    case comments(count: Int)
}

struct RatingView: View {
    let type: RatingViewType
    let showBackground: Bool
    
    init(type: RatingViewType, showBackground: Bool = true) {
        self.type = type
        self.showBackground = showBackground
    }
    
    var body: some View {
        HStack(spacing: 4) {
            switch type {
            case .rating(let value, let count):
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
                
                Text(String(format: "%.1f", value))
                    .font(.headline)
                    .fontWeight(.bold)
                
                if let count = count {
                    Text("\(count) reviews")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
            case .likes(let count):
                Image(systemName: "hand.thumbsup.fill")
                    .foregroundColor(.blue)
                
                Text("\(count)")
                    .font(.headline)
                    .fontWeight(.bold)
                
                Text(count == 1 ? "like" : "likes")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
            case .comments(let count):
                Image(systemName: "bubble.left.fill")
                    .foregroundColor(.green)
                
                Text("\(count)")
                    .font(.headline)
                    .fontWeight(.bold)
                
                Text(count == 1 ? "comment" : "comments")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(
            showBackground ? Color(.systemBackground) : Color.clear
        )
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
        )
        .shadow(color: Color.black.opacity(0.1), radius: 3, x: 0, y: 2)
    }
}
