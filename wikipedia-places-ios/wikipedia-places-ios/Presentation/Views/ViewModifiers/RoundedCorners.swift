//
//  RoundedCorners.swift
//  wikipedia-places-ios
//
//  Created by Rizki Calame on 23/08/2024.
//

import SwiftUI

struct RoundedCorners: ViewModifier {
    func body(content: Content) -> some View {
        content.overlay(
            RoundedRectangle(cornerRadius: 10.0)
                .strokeBorder(
                    Color.gray.opacity(0.5), 
                    style: StrokeStyle(lineWidth: 1.0)
                )
        )
    }
}

extension View {
    func roundedCorners() -> some View {
        self.modifier(RoundedCorners())
    }
}
