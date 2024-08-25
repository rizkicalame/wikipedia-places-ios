//
//  HomeViewModel+Localization.swift
//  wikipedia-places-ios
//
//  Created by Rizki Calame on 25/08/2024.
//

import Foundation

// MARK: - Localization

extension HomeViewModel {
    var navigationTitle: String {
        "Locations"
    }

    var addCustomLocationButtonTitle: String {
        "Add custom location"
    }

    var errorText: String {
        guard case let .error(error) = state else {
            return ""
        }

        return "Error: \(error.localizedDescription)"
    }
}
