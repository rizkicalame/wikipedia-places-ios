//
//  LocationCellView.swift
//  wikipedia-places-ios
//
//  Created by Rizki Calame on 22/08/2024.
//

import SwiftUI

struct LocationCellView: View {
    let name: String
    let coordinates: String
    let onTap: (() -> Void)

    var body: some View {
        Button(action: {
            onTap()
        }, label: {
            VStack(alignment: .leading) {
                Text(name)
                Text(coordinates)
            }
        })
        .buttonStyle(.plain)
    }
}
