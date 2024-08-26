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


    /// Constructs the deeplinking URL specifically for the Wikipedia app.
    /// - Parameter location: Takes the domainModel for Location.
    /// - Returns: A string presentation of the deeplinking URL to the Wikipedia app.
    static func getCoordinatesDeeplinkURL(location: LocationDomainModel) -> String {
        return "\(Self.appHostScheme)\(Self.placesIntent)/?\(Self.coordinatesQueryParameter)=\(location.latitude),\(location.longitude)"
    }
}
