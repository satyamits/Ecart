//
//  SeeAllButton.swift
//  Ecart
//
//  Created by Satyam Singh on 20/04/25.
//


import SwiftUI

struct SeeAllButton: View {
    
    var action: () -> Void
    
    var body: some View {
        Button {
            withAnimation {
                self.action()
            }
        } label: {
            HStack(spacing: 4) {
                Text("See all")
                    .foregroundColor(.gray)
                ZStack {
                    Circle()
                        .fill(Color(.systemGray5))
                        .frame(width: 24, height: 24)
                    
                    Image(systemName: "chevron.right")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 10, height: 10)
                        .foregroundColor(.black)
                }
            }
            .font(.subheadline)
        }
    }
}
