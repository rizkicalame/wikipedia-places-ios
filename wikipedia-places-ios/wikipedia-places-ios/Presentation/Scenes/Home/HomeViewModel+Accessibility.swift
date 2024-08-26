//
//  HomeViewModel+Accessibility.swift
//  wikipedia-places-ios
//
//  Created by Rizki Calame on 25/08/2024.
//

import Foundation

// MARK: - Accessibility
/// Accessibility  extension so that the ViewModel can determine accessibility values.
extension HomeViewModel {
    func accessibilityLabel(for location: LocationDomainModel) -> String {
        if let name = location.name {
            return "Location for \(name), with latitude: \(location.latitude) and longitude: \(location.longitude)"
        } else {
            return "Coordinates for an unknown location, with latitude: \(location.latitude) and longitude: \(location.longitude)"
        }
    }

    func accessibilityHint(for location: LocationDomainModel) -> String {
        if let name = location.name {
            return "Tap to see \(name) in the Wikipedia app."
        } else {
            return "Tap to see the coordinates with latitude: \(location.latitude) and longitude: \(location.longitude) in the Wikipedia app."
        }
    }

    var accessibilityLabelAddCustomLocationButton: String {
        "Add a custom location"
    }

    var accessibilityHintAddCustomLocationButton: String {
        "Tap to start adding a custom location"
    }
}
