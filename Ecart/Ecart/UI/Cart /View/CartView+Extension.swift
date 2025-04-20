//
//  CartView+Extension.swift
//  Ecart
//
//  Created by Satyam Singh on 20/04/25.
//

import Foundation
import SwiftUI

extension CartView {
    
    // MARK: Header
    var headerView: some View {
        VStack(spacing: 12) {
            HStack {
                Text("Cart")
                    .font(.title.bold())
                    .foregroundColor(Color.black)
                Spacer()
                
                Button {
                    
                    // Handle notification tap
                    
                } label :{
                    ZStack {
                        
                        Image(systemName: "ellipsis")
                            .resizable()
                            .foregroundColor(.black)
                            
                            .frame(width: 18, height: 3)
                            .padding(24)
                            .background(Color(.systemGray6))
                            .clipShape(Circle())
                    }
                }.foregroundColor(.clear)
            }
            // Search Bar
            Button {
                
            } label: {
                ZStack {
                    HStack(spacing: 12) {
                        
                        
                            Image(systemName: "location")
                                .resizable()
                                .foregroundColor(.gray)
                                .frame(width: 20, height: 20)
                            Text("92 High Street, London")
                                .foregroundColor(.gray)
                            
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                                .padding(.trailing, 10)
                        
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(15)
                }
            }
            
        }
        
        .padding(.horizontal, 18)
        .padding(.bottom, 12)
        .clipShape(RoundedCorner(radius: 28, corners: [.bottomLeft, .bottomRight]))
        .background(Color.white.ignoresSafeArea(edges: .top))
        
        .shadow(color: .gray.opacity(0.1), radius: 4, x: 0, y: 2)
        
        
    }
}
