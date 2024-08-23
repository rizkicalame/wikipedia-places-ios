//
//  FormInputField.swift
//  wikipedia-places-ios
//
//  Created by Rizki Calame on 23/08/2024.
//

import SwiftUI

struct FormInputField: View {

    // MARK: - Constants

    private enum Style {
        static let padding = 8.0
    }

    // MARK: - Properties

    let placeholder: String
    let textBinding: Binding<String>

    // MARK: - View

    var body: some View {
        TextField(placeholder, text: textBinding)
            .textContentType(.addressCity)
            .padding(Style.padding)
            .roundedCorners()
    }
}
