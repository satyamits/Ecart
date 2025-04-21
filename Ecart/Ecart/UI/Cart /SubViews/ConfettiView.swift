//
//  ConfettiView.swift
//  Ecart
//
//  Created by Satyam Singh on 20/04/25.
//

import SwiftUI

struct ConfettiView: View {
    @State private var isAnimating = false

    var body: some View {
        ZStack {
            ForEach(0..<12, id: \.self) { i in
                Circle()
                    .fill(confettiColors.randomElement() ?? .red)
                    .frame(width: 8, height: 8)
                    .offset(x: isAnimating ? CGFloat.random(in: -100...100) : 0,
                            y: isAnimating ? CGFloat.random(in: -150...150) : 0)
                    .opacity(isAnimating ? 0 : 1)
                    .animation(Animation.easeOut(duration: 1).delay(Double(i) * 0.05), value: isAnimating)
            }
        }
        .onAppear {
            isAnimating = true
        }
    }

    private var confettiColors: [Color] {
        [.green, .blue, .orange, .pink, .yellow, .purple]
    }
}
