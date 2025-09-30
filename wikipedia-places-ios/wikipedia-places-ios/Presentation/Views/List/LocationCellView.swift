//
//  LocationCellView.swift
//  wikipedia-places-ios
//
//  Created by Rizki Calame on 22/08/2024.
//

import SwiftUI

struct LocationCellView: View {

    // MARK: - Properties

    let name: String
    let coordinates: String
    let onTap: (() -> Void)

    // MARK: - View

    var body: some View {
        VStack(alignment: .leading) {
            Text(name)
            Text(coordinates)
        }
        .frame(maxWidth: .infinity, alignment: .init(horizontal: .leading, vertical: .center))
        .contentShape(Rectangle())
        .onTapGesture {
            onTap()
        }
    }
}
