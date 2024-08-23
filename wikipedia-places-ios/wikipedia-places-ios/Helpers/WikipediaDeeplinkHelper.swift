//
//  WikipediaDeeplinkHelper.swift
//  wikipedia-places-ios
//
//  Created by Rizki Calame on 23/08/2024.
//

import Foundation

enum WikipediaDeeplinkHelper {

    // MARK: - Constants

    private static let appHostScheme = "wikipedia://"
    private static let placesIntent = "places"
    private static let coordinatesQueryParameter = "WMFPlacesCoordinates"

    // MARK: - Static

    static func getCoordinatesDeeplinkURL(location: LocationDomainModel) -> String {
        return "\(Self.appHostScheme)\(Self.placesIntent)/?\(Self.coordinatesQueryParameter)=\(location.latitude),\(location.longitude)"
    }
}
