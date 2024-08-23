//
//  RoundedCorners.swift
//  wikipedia-places-ios
//
//  Created by Rizki Calame on 23/08/2024.
//

import SwiftUI

struct RoundedCorners: ViewModifier {

    // MARK: - Constants

    private enum Style {
        static let cornerRadius = 16.0
        static let strokeOpacity = 0.5
        static let strokeLineWidth = 1.0
    }

    // MARK: - View

    func body(content: Content) -> some View {
        content.overlay(
            RoundedRectangle(cornerRadius: Style.cornerRadius)
                .strokeBorder(
                    Color.gray.opacity(Style.strokeOpacity),
                    style: StrokeStyle(lineWidth: Style.strokeLineWidth)
                )
        )
    }
}

extension View {
    func roundedCorners() -> some View {
        self.modifier(RoundedCorners())
    }
}
