//
//  FlashSaleSectionView.swift
//  Ecart
//
//  Created by Satyam Singh on 20/04/25.
//

import SwiftUI

struct FlashSaleSectionView: View {
    
    @StateObject var viewModel: HomeViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Flash Sale")
                    .font(.title3).bold()
                
                HStack(spacing: 8) {
                    Text(self.viewModel.formattedFlashSaleTime())
                        .font(.caption)
                        .padding(6)
                        .background(Color(.systemGreen).opacity(0.4))
                        .cornerRadius(6)
                    Spacer()
                    SeeAllButton {
                        // Handle tap
                    }
                }
            }

            ProductListView(viewModel: self.viewModel)
        }
    }
}
