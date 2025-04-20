//
//  CategorySectionView.swift
//  Ecart
//
//  Created by Satyam Singh on 20/04/25.
//


import SwiftUI

import SwiftUI

struct CategorySectionView: View {
    let categories: [Category]
    @Binding var selectedCategory: Category?

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Categories")
                    .font(.title.bold())

                Spacer()

                SeeAllButton() {
                    withAnimation {
                        self.selectedCategory = nil
                    }
                }
            }
            .padding(.horizontal)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(self.categories, id: \.self) { category in
                        Button {
                            withAnimation {
                                self.selectedCategory = category
                            }
                        } label: {
                            CategoryItem(
                                icon: self.iconForCategory(category),
                                label: category.rawValue.capitalized,
                                isSelected: self.selectedCategory == category
                            )
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
        .padding(.vertical, 12)
    }

    private func iconForCategory(_ category: Category) -> String {
        switch category {
        case .electronics: return "tv"
        case .jewelery: return "diamond"
        case .menSClothing: return "tshirt"
        case .womenSClothing: return "person.crop.circle.badge.plus"
        }
    }
}

