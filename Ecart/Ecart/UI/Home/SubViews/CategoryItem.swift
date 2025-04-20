//
//  CategoryItem.swift
//  Ecart
//
//  Created by Satyam Singh on 20/04/25.
//


import SwiftUI

struct CategoryItem: View {
    
    let icon: String
    let label: String
    let isSelected: Bool

    var body: some View {
        VStack(spacing: 8) {
            Circle()
                .fill(self.isSelected ? Color.blue.opacity(0.1) : Color.gray.opacity(0.1))
                .frame(width: 60, height: 60)
                .overlay(
                    Image(systemName: self.icon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 28, height: 28)
                        .foregroundColor(.black)
                )

            Text(self.label)
                .font(.footnote)
                .foregroundColor(.primary)
        }
        .padding(.horizontal, 4)
    }
}
