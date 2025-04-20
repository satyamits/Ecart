//
//  RoundedCorner.swift
//  Ecart
//
//  Created by Satyam Singh on 20/04/25.
//

import SwiftUI

struct RoundedCorner: Shape {
    
    var radius: CGFloat = 24
    var corners: UIRectCorner

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}
