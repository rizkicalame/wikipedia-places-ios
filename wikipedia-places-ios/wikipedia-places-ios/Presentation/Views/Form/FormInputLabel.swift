//
//  FormInputLabel.swift
//  wikipedia-places-ios
//
//  Created by Rizki Calame on 23/08/2024.
//

import SwiftUI

struct FormInputLabel: View {

    // MARK: - Properties

    let title: String

    // MARK: - View

    var body: some View {
        Text(title)
            .frame(maxWidth: .infinity, alignment: .leading)
            .listRowSeparator(.hidden)
    }
}
