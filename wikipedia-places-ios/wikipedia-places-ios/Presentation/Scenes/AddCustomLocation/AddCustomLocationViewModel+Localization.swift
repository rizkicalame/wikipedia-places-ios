//
//  AddCustomLocationViewModel+Localization.swift
//  wikipedia-places-ios
//
//  Created by Rizki Calame on 25/08/2024.
//

import Foundation

// MARK: Localization
/// Localization extension so that the ViewModel can hold texts and becomes testable.
extension AddCustomLocationViewModel {

    var locationFormTitle: String {
        "Name of location"
    }

    var locationPlaceholder: String {
        "E.g. Amsterdam"
    }

    var latitudeFormTitle: String {
        "Latitude"
    }

    var latitudePlaceholder: String {
        "52.0000"
    }

    var longitudeFormTitle: String {
        "Longitude"
    }

    var longitudePlaceholder: String {
        "14.0000"
    }

    var submitButtonTitle: String {
        "Submit"
    }

    var navigationTitle: String {
        "Add custom location"
    }
}
