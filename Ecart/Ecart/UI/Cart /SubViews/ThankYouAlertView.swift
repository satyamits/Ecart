//
//  ThankYouAlertView.swift
//  Ecart
//
//  Created by Satyam Singh on 20/04/25.
//
import SwiftUI

struct ThankYouAlertView: View {
    var onDismiss: () -> Void
    @State private var scale: CGFloat = 0.5

    var body: some View {
        ZStack {
            ConfettiView()
                .frame(width: 300, height: 300)
                .clipped()
            
            VStack(spacing: 16) {
                Text("Thank You!")
                    .font(.title)
                    .fontWeight(.bold)
                
                ZStack {
                    Circle()
                        .fill(Color.green.opacity(0.2))
                        .frame(width: 80, height: 80)
                    Image(systemName: "gift.fill")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.green)
                        .frame(width: 40, height: 40)
                }

                Text("Your order has been placed successfully!")
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                Button(action: onDismiss) {
                    Text("Okay")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .cornerRadius(10)
                }
            }
            .padding()
            .frame(maxWidth: 300)
            .background(Color.white)
            .cornerRadius(20)
            .shadow(radius: 10)
            .scaleEffect(scale)
            .onAppear {
                withAnimation(.spring(response: 0.4, dampingFraction: 0.5)) {
                    scale = 1.0
                }
            }
        }
    }
}

