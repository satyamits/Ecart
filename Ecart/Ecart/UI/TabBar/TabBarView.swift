//
//  TabBarView.swift
//  Ecart
//
//  Created by Satyam Singh on 20/04/25.
//


import SwiftUI

enum Tab: Int {
    case home, catalog, cart, favorites, profile
}

struct TabBarView: View {
    @Binding var selectedTab: Tab
    var cartItemCount: Int

    var body: some View {
        HStack {
            tabButton(icon: "house.fill", title: "Home", tab: .home, color: Color(.systemGreen))
            tabButton(icon: "arrow.triangle.2.circlepath", title: "Catalog", tab: .catalog)
            cartButton(icon: "cart", title: "Cart", tab: .cart)
            tabButton(icon: "heart", title: "Favorites", tab: .favorites)
            tabButton(icon: "person", title: "Profile", tab: .profile)
        }
        .padding(.vertical, 12)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))
        .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: -2)
    }

    private func tabButton(icon: String, title: String, tab: Tab, color: Color = .gray) -> some View {
        VStack(spacing: 4) {
            if selectedTab == tab {
                Image(systemName: icon)
                    .foregroundColor(.white)
                    .padding(10)
                    .background(color)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
            } else {
                Image(systemName: icon)
                    .foregroundColor(.gray)
                    .padding(10)
            }

            Text(title)
                .font(.caption)
                .foregroundColor(selectedTab == tab ? color : .gray)
        }
        .frame(maxWidth: .infinity)
        .onTapGesture {
            selectedTab = tab
        }
    }

    private func cartButton(icon: String, title: String, tab: Tab) -> some View {
        VStack(spacing: 4) {
            ZStack(alignment: .topTrailing) {
                Image(systemName: icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 22, height: 22)
                    .foregroundColor(selectedTab == tab ? .black : .gray)
                    .padding(10)

                if cartItemCount > 0 {
                    Text("\(cartItemCount)")
                        .font(.system(size: 10, weight: .bold))
                        .foregroundColor(.white)
                        .frame(width: 18, height: 18)
                        .background(Color.black)
                        .clipShape(Circle())
                        .offset(x: 10, y: -8)
                }
            }

            Text(title)
                .font(.caption)
                .foregroundColor(selectedTab == tab ? .black : .gray)
        }
        .frame(maxWidth: .infinity)
        .onTapGesture {
            selectedTab = tab
        }
    }

}
